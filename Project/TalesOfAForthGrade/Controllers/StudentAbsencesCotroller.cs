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
using TalesOfAForthGrade.DTO.Absence;

namespace TalesOfAForthGrade.Controllers
{
    [ApiController]
    [Route("students/absences")]
    public class StudentAbsencesController : ControllerBase{
        private readonly IStudentsRepository studentsRepository;
        private readonly IProfessorRepository professorsRepository;
        private readonly IAbsensesRepository absensesRepository;

        public StudentAbsencesController(IStudentsRepository studentsRepository, IProfessorRepository professorRepository, IAbsensesRepository absensesRepository){
            this.studentsRepository = studentsRepository;
            this.professorsRepository = professorRepository;
            this.absensesRepository = absensesRepository;
        }


        [Authorize(Roles = "Professor")]
        [HttpGet("{id}")]
        public async Task<IEnumerable<AbsenceDTO>> GetStudentAbsencesAsync(Guid id){
            var absences = (await absensesRepository.GetAbsencesStudentAsync(id)).Select(abs => abs.AsDto());

            return absences;
        }


        [Authorize(Roles = "Professor")]
        [HttpPost]
        public async Task<ActionResult<StudentDTO>> AddAbsence(CreateAbsenceDTO createAbsenceDTO){

            Professor professor = await professorsRepository.GetProfessorAsync(Guid.Parse(User.Claims.FirstOrDefault(a => a.Type == "id").Value));
            Student existingStudent = await studentsRepository.GetStudentAsync(createAbsenceDTO.Student);

            if(existingStudent == null){
                return NotFound(new {
                    message = "Students with id " + createAbsenceDTO.Student + " not found"
                });
            }

            List<Guid> existingAbsences = new List<Guid>(existingStudent.Absences);

            Absence absence = new(){
                Id = Guid.NewGuid(),
                Student = createAbsenceDTO.Student,
                Subject = professor.Subject,
                Date = createAbsenceDTO.Date,
                motivation = "",
                excused = false
            };

            existingAbsences.Add(absence.Id);


            await absensesRepository.CreateAbsenceAsync(absence);


            await studentsRepository.UpdateStudentAsync(new Student{
                Id = existingStudent.Id,
                LastName = existingStudent.LastName,
                FirstName = existingStudent.FirstName,
                CNP = existingStudent.CNP,
                Password = existingStudent.Password,
                Grades = existingStudent.Grades,
                Absences = existingAbsences.ToArray(),
                Assignments = existingStudent.Assignments
            });

            return Created("/absences", absence);
        }

        [Authorize(Roles = "Professor")]
        [HttpPut("{id}")]
        public async Task<ActionResult> UpdateStudentGradeAsync(Guid id, UpdateAbsenceDTO updateAbsenceDTO){
            var existingItem = await absensesRepository.GetAbsence(id);

            if(existingItem is null){
                return NotFound();
            }

            Absence updatedAbsence = existingItem with {
                Id = existingItem.Id,
                Student = existingItem.Student,
                Subject = existingItem.Subject,
                excused = updateAbsenceDTO.excused,
                motivation = updateAbsenceDTO.motivation,
                Date = existingItem.Date
            };

            await absensesRepository.UpdateAbsenceAsync(updatedAbsence);

            return NoContent();
        }

    }
}