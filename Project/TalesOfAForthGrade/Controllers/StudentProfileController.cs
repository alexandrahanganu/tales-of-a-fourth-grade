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
using TalesOfAForthGrade.DTO.Absence;
using TalesOfAForthGrade.DTO.Assignment;

namespace TalesOfAForthGrade.Controllers
{
    [ApiController]
    [Route("profile")]
    public class StudentProfileController : ControllerBase{
        private readonly IStudentsRepository repository;

        private readonly IGradesRepository gradesRepository;

        private readonly ISubjectsRepository subjectsRepository;

        private readonly IAbsensesRepository absensesRepository;

        private readonly IAssignmentsRepository assignmentsRepository;

        public StudentProfileController(
        IStudentsRepository repository, 
        IGradesRepository gradesRepository, 
        ISubjectsRepository subjectsRepository, 
        IAbsensesRepository absensesRepository,
        IAssignmentsRepository assignmentsRepository){

            this.repository = repository;
            this.gradesRepository = gradesRepository;
            this.subjectsRepository = subjectsRepository;
            this.absensesRepository = absensesRepository;
            this.assignmentsRepository = assignmentsRepository;
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

            var absences = await absensesRepository.GetAbsencesStudentAsync(student.Id);

            List<AbsenceDataDTO> absenceDatas = new List<AbsenceDataDTO>();

            foreach(Absence absence in absences){
                absenceDatas.Add(new AbsenceDataDTO{
                    Id = absence.Id,
                    Subject = (await subjectsRepository.GetSubjectAsync(absence.Subject)).Title,
                    excused = absence.excused,
                    motivation = absence.motivation,
                    Date = absence.Date
                });
            }

            var assignments = await assignmentsRepository.GetAssignmentsStudentAsync(student.Id);

            List<AssignmentDataDTO> assignmentDatas = new List<AssignmentDataDTO>();
            
            foreach(Assignment assignment in assignments){
                assignmentDatas.Add(new AssignmentDataDTO{
                    Id = assignment.Id,
                    Student = assignment.Student,
                    Subject = (await subjectsRepository.GetSubjectAsync(assignment.Subject)).Title,
                    Done = assignment.Done,
                    DateFrom = assignment.DateFrom,
                    DateDue = assignment.DateDue
                });
            }

            return student.AsProfileDto(gradesDto, absenceDatas, assignmentDatas);
        }
    }
}