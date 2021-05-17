using System.Linq;
using System;
using System.Collections.Generic;
using Microsoft.AspNetCore.Mvc;

using TalesOfAForthGrade.Repositories;
using TalesOfAForthGrade.DTO.Student;
using TalesOfAForthGrade.Entities;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Authorization;
using TalesOfAForthGrade.Helper;
using System.Security.Cryptography;
using TalesOfAForthGrade.DTO.Grade;
using TalesOfAForthGrade.DTO.Assignment;
using TalesOfAForthGrade.DTO.Absence;

namespace TalesOfAForthGrade.Controllers
{
    [ApiController]
    [Route("students/info")]
    public class StudentsInfoController : ControllerBase{
        private readonly IStudentsRepository repository;
        private readonly IGradesRepository gradesRepository;
        private readonly IAbsensesRepository absensesRepository;
        private readonly IAssignmentsRepository assignmentsRepository;
        private readonly IProfessorRepository professorRepository;
        private readonly ISubjectsRepository subjectsRepository;

        public StudentsInfoController(
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

        [Authorize(Roles = "Professor,Admin")]
        [HttpGet]
        public async Task<IEnumerable<StudentDTO>> GetStudentsAsync(){
            var students = (await repository.GetStudentsAsync())
                            .Select(student => student.AsDto());
            return students;
        }

        [Authorize(Roles = "Professor,Admin")]
        [HttpGet("{id}")]
        public async Task<ActionResult<StudentProfileDTO>> GetStudentAsync(Guid id){
            
            var student = await repository.GetStudentAsync(id);

            if (student is null){
                return NotFound(new {
                    message = "Student was not found",
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

        [Authorize(Roles = "Admin")]
        [HttpPost]
        public async Task<ActionResult<StudentDTO>> CreateStudentAsync(CreateStudentDTO studentDTO){
            Student student = new(){
                Id = Guid.NewGuid(),
                FirstName = studentDTO.FirstName,
                LastName = studentDTO.LastName,
                CNP = studentDTO.CNP,
                Grades = Array.Empty<Guid>(),
                Absences = Array.Empty<Guid>(),
                Assignments = Array.Empty<Guid>()
            };

            await repository.CreateStudentAsync(student);

            return CreatedAtAction(nameof(GetStudentAsync), new {id = student.Id}, student.AsDto());
        }

        [Authorize(Roles = "Admin")]
        [HttpPost ]
        [Route("list")]
        public async Task<IEnumerable<NewlyCreatedStudentDTO>> CreateStudentsAsync(List<CreateStudentDTO> studentsDTO){
            List<NewlyCreatedStudentDTO> newlyCreatedStudentDTOs = new List<NewlyCreatedStudentDTO>();
            foreach(CreateStudentDTO studentDTO in studentsDTO){

                string password = RandomHelper.GenerateRandomString(12);
                Guid id = Guid.NewGuid();

                newlyCreatedStudentDTOs.Add(new(){
                    Id = id,
                    FirstName = studentDTO.FirstName,
                    LastName = studentDTO.LastName,
                    CNP = studentDTO.CNP,
                    password = password
                });

                Student student = new(){
                    Id = id,
                    FirstName = studentDTO.FirstName,
                    LastName = studentDTO.LastName,
                    CNP = studentDTO.CNP,
                    Password = CryptoHelper.hashPassword(password),
                    Grades = Array.Empty<Guid>(),
                    Absences = Array.Empty<Guid>(),
                    Assignments = Array.Empty<Guid>()
                };

                await repository.CreateStudentAsync(student);
            }

            return newlyCreatedStudentDTOs;
        }

        [Authorize(Roles = "Professor,Admin")]
        [HttpPut("{id}")]
        public async Task<ActionResult> UpdateStudentAsync(Guid id, UpdateStudentDTO studentDTO){
            var existingItem = await repository.GetStudentAsync(id);

            if(existingItem is null){
                return NotFound();
            }

            Student updatedStudent = existingItem with {
                FirstName = studentDTO.FirstName,
                LastName = studentDTO.LastName,
                CNP = studentDTO.CNP,
            };

            await repository.UpdateStudentAsync(updatedStudent);

            return NoContent();
        }

        [Authorize(Roles = "Admin")]
        [HttpDelete("{id}")]
        public async Task<ActionResult> DeleteStudent(Guid id){
            var existingItem = await repository.GetStudentAsync(id);

            if(existingItem is null){
                return NotFound();
            }

            repository.DeleteStudentAsync(existingItem.Id);

            return NoContent();
        }

    }
}