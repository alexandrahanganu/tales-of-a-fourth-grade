using System.Runtime.CompilerServices;
using System.Linq;
using System;
using System.Collections.Generic;
using Microsoft.AspNetCore.Mvc;

using TalesOfAForthGrade.Repositories;
using TalesOfAForthGrade.DTO.Student;
using TalesOfAForthGrade.Entities;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Authorization;
using MongoDB.Driver;
using TalesOfAForthGrade.DTO.Grade;

namespace TalesOfAForthGrade.Controllers
{
    [ApiController]
    [Route("students/grades")]
    public class StudentsGradesController : ControllerBase{
        private readonly IStudentsRepository studentsRepository;
        private readonly IProfessorRepository professorsRepository;
        private readonly IGradesRepository gradesRepository;

        public StudentsGradesController(IStudentsRepository studentsRepository, IProfessorRepository professorRepository, IGradesRepository gradesRepository){
            this.studentsRepository = studentsRepository;
            this.professorsRepository = professorRepository;
            this.gradesRepository = gradesRepository;
        }

        [Authorize(Roles = "Professor")]
        [HttpGet]
        public async Task<IEnumerable<GradeDTO>> GetAllGradesAsync(){
            var grades = (await gradesRepository.GetGradesAsync())
                            .Select(grades => grades.AsDto());
            return grades;
        }

        [Authorize(Roles = "Professor")]
        [HttpGet("{id}")]
        public async Task<IEnumerable<GradeDTO>> GetStudentGradesAsync(Guid id){
            var grades = (await gradesRepository.GetGradesStudentAsync(id)).Select(grades => grades.AsDto());

            return grades;
        }

        // [Authorize(Roles = "Professor")]
        // [HttpGet("{id}")]
        // public async Task<GradeDTO> GetGradeAsync(Guid id){
        //     Grade grade = await gradesRepository.GetGradeAsync(id);

        //     return grade.AsDto();
        // }

        [Authorize(Roles = "Professor")]
        [HttpPost]
        public async Task<ActionResult<StudentDTO>> AddGrade(CreateGradeDTO createGradeDTO){

            Professor professor = await professorsRepository.GetProfessorAsync(Guid.Parse(User.Claims.Where(a => a.Type == "id").FirstOrDefault().Value));
            Student existingStudent = await studentsRepository.GetStudentAsync(createGradeDTO.Student);

            if(existingStudent == null){
                return NotFound(new {
                    message = "Students with id " + createGradeDTO.Student + " not found",
                    value = createGradeDTO.Value,
                    date = createGradeDTO.Date
                });
            }

            List<Guid> existingGrades = new List<Guid>(existingStudent.Grades);

            // List<Guid> existingGrades = new List<Guid>();

            // if(existingStudent.Grades.Length > 0){
            //     existingGrades.AddRange(existingStudent.Grades);
            // }

            Grade grade = new(){
                Id = Guid.NewGuid(),
                Student = createGradeDTO.Student,
                Subject = professor.Subject,
                Value = createGradeDTO.Value,
                Date = createGradeDTO.Date
            };

            existingGrades.Add(grade.Id);


            await gradesRepository.CreateGradeAsync(grade);


            await studentsRepository.UpdateStudentAsync(new Student{
                Id = existingStudent.Id,
                LastName = existingStudent.LastName,
                FirstName = existingStudent.FirstName,
                CNP = existingStudent.CNP,
                Password = existingStudent.Password,
                Grades = existingGrades.ToArray(),
                Absences = existingStudent.Absences
            });

            return Created("/grades", grade);
        }

        [Authorize(Roles = "Professor")]
        [HttpPut("{id}")]
        public async Task<ActionResult> UpdateStudentGradeAsync(Guid id, UpdateGradeDTO updateGradeDTO){
            var existingItem = await gradesRepository.GetGradeAsync(id);

            if(existingItem is null){
                return NotFound();
            }

            //TODO: Should check if the Professor that requested the change is the one that created the grade

            Grade updatedGrade = existingItem with {
                Id = existingItem.Id,
                Student = existingItem.Student,
                Subject = existingItem.Subject,
                Value = updateGradeDTO.Value,
                Date = existingItem.Date
            };

            await gradesRepository.UpdateGradeAsync(updatedGrade);

            return NoContent();
        }

    }
}