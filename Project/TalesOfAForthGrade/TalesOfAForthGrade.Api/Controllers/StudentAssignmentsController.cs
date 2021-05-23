using System.Linq;
using System;
using System.Collections.Generic;
using Microsoft.AspNetCore.Mvc;

using TalesOfAForthGrade.Api.Repositories;
using TalesOfAForthGrade.Api.DTO.Student;
using TalesOfAForthGrade.Api.Entities;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Authorization;
using MongoDB.Driver;
using TalesOfAForthGrade.Api.DTO.Grade;
using TalesOfAForthGrade.Api.DTO.Absence;
using TalesOfAForthGrade.Api.DTO.Assignment;

namespace TalesOfAForthGrade.Api.Controllers
{
    [ApiController]
    [Route("students/assignments")]
    public class StudentAssignmentsController : ControllerBase{
        private readonly IStudentsRepository studentsRepository;
        private readonly IProfessorRepository professorsRepository;
        private readonly IAssignmentsRepository assignmentsRepository;

        public StudentAssignmentsController(IStudentsRepository studentsRepository, IProfessorRepository professorRepository, IAssignmentsRepository assignmentsRepository){
            this.studentsRepository = studentsRepository;
            this.professorsRepository = professorRepository;
            this.assignmentsRepository = assignmentsRepository;
        }


        [Authorize(Roles = "Professor")]
        [HttpGet("{id}")]
        public async Task<IEnumerable<AssignmentDTO>> GetStudentAssignmentsAsync(Guid id){
            var assignments = (await assignmentsRepository.GetAssignmentsStudentAsync(id)).Select(abs => abs.AsDto());

            return assignments;
        }


        [Authorize(Roles = "Professor")]
        [HttpPost]
        public async Task<ActionResult<StudentDTO>> AddAssignment(CreateAssignmentDTO createAssignmentDTO){

            Professor professor = await professorsRepository.GetProfessorAsync(Guid.Parse(User.Claims.FirstOrDefault(a => a.Type == "id").Value));
            Student existingStudent = await studentsRepository.GetStudentAsync(createAssignmentDTO.Student);

            if(existingStudent == null){
                return NotFound(new {
                    message = "Students with id " + createAssignmentDTO.Student + " not found"
                });
            }

            List<Guid> existingAssignments = new List<Guid>(existingStudent.Assignments);

            Assignment assignment = new(){
                Id = Guid.NewGuid(),
                Student = createAssignmentDTO.Student,
                Subject = professor.Subject,
                Done = false,
                DateFrom = createAssignmentDTO.DateFrom,
                DateDue = createAssignmentDTO.DateDue
            };

            existingAssignments.Add(assignment.Id);


            await assignmentsRepository.CreateAssignmentAsync(assignment);


            await studentsRepository.UpdateStudentAsync(new Student{
                Id = existingStudent.Id,
                LastName = existingStudent.LastName,
                FirstName = existingStudent.FirstName,
                CNP = existingStudent.CNP,
                Password = existingStudent.Password,
                Grades = existingStudent.Grades,
                Absences = existingStudent.Absences,
                Assignments = existingAssignments.ToArray()
            });

            return Created("/assignments", assignment);
        }

        [Authorize(Roles = "Professor")]
        [HttpPut("{id}")]
        public async Task<ActionResult> UpdateStudentAssignmentAsync(Guid id, UpdateAssignmentDTO updateAssignmentDTO){
            var existingItem = await assignmentsRepository.GetAssignmentAsync(id);

            if(existingItem is null){
                return NotFound();
            }

            Assignment updatedAssignment = existingItem with {
                Done = updateAssignmentDTO.Done,
                DateDue = updateAssignmentDTO.DateDue
            };

            await assignmentsRepository.UpdateAssignmentsAsync(updatedAssignment);

            return NoContent();
        }

    }
}