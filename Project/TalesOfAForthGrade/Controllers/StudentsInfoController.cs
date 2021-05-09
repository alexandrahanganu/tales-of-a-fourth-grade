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

namespace TalesOfAForthGrade.Controllers
{
    [ApiController]
    [Route("students/info")]
    public class StudentsInfoController : ControllerBase{
        private readonly IStudentsRepository repository;

        public StudentsInfoController(IStudentsRepository repository){
            this.repository = repository;
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
        public async Task<ActionResult<StudentDTO>> GetStudentAsync(Guid id){
            var student = await repository.GetStudentAsync(id);

            if (student is null){
                return NotFound();
            }

            return student.AsDto();
        }

        //[Authorize(Roles = "Admin")]
        [HttpPost]
        public async Task<ActionResult<StudentDTO>> CreateStudentAsync(CreateStudentDTO studentDTO){
            Student student = new(){
                Id = Guid.NewGuid(),
                FirstName = studentDTO.FirstName,
                LastName = studentDTO.LastName,
                CNP = studentDTO.CNP,
                Grades = Array.Empty<Guid>(),
                Absences = Array.Empty<Guid>()
            };

            await repository.CreateStudentAsync(student);

            return CreatedAtAction(nameof(GetStudentAsync), new {id = student.Id}, student.AsDto());
        }

        //[Authorize(Roles = "Admin")]
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
                    Absences = Array.Empty<Guid>()
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