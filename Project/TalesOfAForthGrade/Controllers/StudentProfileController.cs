using System.Linq;
using System;
using Microsoft.AspNetCore.Mvc;

using TalesOfAForthGrade.Repositories;
using TalesOfAForthGrade.DTO.Student;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Authorization;
using MongoDB.Driver;
using TalesOfAForthGrade.Entities;
using System.Collections.Generic;
using TalesOfAForthGrade.DTO.Grade;

namespace TalesOfAForthGrade.Controllers
{
    [ApiController]
    [Route("profile")]
    public class StudentProfileController : ControllerBase{
        private readonly IStudentsRepository repository;

        private readonly IGradesRepository gradesRepository;

        private readonly ISubjectsRepository subjectsRepository;

        public StudentProfileController(IStudentsRepository repository, IGradesRepository gradesRepository, ISubjectsRepository subjectsRepository){
            this.repository = repository;
            this.gradesRepository = gradesRepository;
            this.subjectsRepository = subjectsRepository;
        }

        [Authorize(Roles = "Student")]
        [HttpGet]
        public async Task<ActionResult<StudentProfileDTO>> GetStudentAsync(){

            var id = User.Claims.FirstOrDefault(a => a.Type == "id").Value;

            var student = await repository.GetStudentAsync(Guid.Parse(id));

            if (student is null){
                return BadRequest(new {
                    message = "There was an error with your authentication, please login again, if the problem persists contact your admin",
                });
            }

            var grades = await gradesRepository.GetGradesStudentAsync(student.Id);

            List<GradeDataDTO> gradesDto = new List<GradeDataDTO>();

            foreach(Grade grade in grades){
                gradesDto.Add(new GradeDataDTO{
                    Subject = (await subjectsRepository.GetSubjectAsync(grade.Subject)).Title,
                    Value = grade.Value,
                    Date = grade.Date
                });
            }

            return student.AsProfileDto(gradesDto);
        }
    }
}