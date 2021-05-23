using System.Linq;
using System;
using System.Collections.Generic;
using Microsoft.AspNetCore.Mvc;

using TalesOfAForthGrade.Api.Repositories;
using TalesOfAForthGrade.Api.DTO.Student;
using TalesOfAForthGrade.Api.Entities;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Authorization;
using TalesOfAForthGrade.Api.Helper;
using TalesOfAForthGrade.Api.Services;
using TalesOfAForthGrade.Helper;

namespace TalesOfAForthGrade.Api.Controllers
{
    [ApiController]
    [Route("students/info")]
    public class StudentsInfoController : ControllerBase{
        private readonly IStudentsRepository repository;

        private readonly StudentServices studentServices;

        public StudentsInfoController(
            IStudentsRepository repository, 
            IGradesRepository gradesRepository, 
            ISubjectsRepository subjectsRepository, 
            IAbsensesRepository absensesRepository,
            IAssignmentsRepository assignmentsRepository){
            
            this.repository = repository;

            studentServices = new StudentServices(gradesRepository, subjectsRepository, absensesRepository, assignmentsRepository);
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

            return await studentServices.GetStudentProfile(student);
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