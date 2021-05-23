using System.Linq;
using System;
using Microsoft.AspNetCore.Mvc;

using TalesOfAForthGrade.Api.Repositories;
using TalesOfAForthGrade.Api.DTO.Student;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Authorization;
using MongoDB.Driver;
using TalesOfAForthGrade.Api.Entities;
using System.Collections.Generic;
using TalesOfAForthGrade.Api.DTO.Grade;
using TalesOfAForthGrade.Api.DTO.Absence;
using TalesOfAForthGrade.Api.DTO.Assignment;
using TalesOfAForthGrade.Api.Services;

namespace TalesOfAForthGrade.Api.Controllers
{
    [ApiController]
    [Route("profile")]
    public class StudentProfileController : ControllerBase{
        private readonly IStudentsRepository repository;
        private readonly StudentServices studentServices;

        public StudentProfileController(
        IStudentsRepository repository, 
        IGradesRepository gradesRepository, 
        ISubjectsRepository subjectsRepository, 
        IAbsensesRepository absensesRepository,
        IAssignmentsRepository assignmentsRepository){

            this.repository = repository;

            studentServices = new StudentServices(gradesRepository, subjectsRepository, absensesRepository, assignmentsRepository);
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

            return await studentServices.GetStudentProfile(student);      
    }
    }
}