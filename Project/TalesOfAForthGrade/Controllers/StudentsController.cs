using System.Runtime.CompilerServices;
using System.Linq;
using System;
using System.Collections.Generic;
using Microsoft.AspNetCore.Mvc;

using TalesOfAForthGrade.Repositories;
using TalesOfAForthGrade.DTO;
using TalesOfAForthGrade.Entities;
using System.Threading.Tasks;

namespace TalesOfAForthGrade.Controllers
{
    [ApiController]
    [Route("students")]
    public class StudentsController : ControllerBase{
        private readonly IStudentsRepository repository;

        public StudentsController(IStudentsRepository repository){
            this.repository = repository;
        }

        [HttpGet]
        public async Task<IEnumerable<StudentDTO>> GetStudentsAsync(){
            var students = (await repository.GetStudentsAsync())
                            .Select(student => student.AsDto());
            return students;
        }

        [HttpGet("{id}")]
        public async Task<ActionResult<StudentDTO>> GetStudentAsync(Guid id){
            var student = await repository.GetStudentAsync(id);

            if (student is null){
                return NotFound();
            }

            return student.AsDto();
        }

        [HttpPost]
        public async Task<ActionResult<StudentDTO>> CreateStudentAsync(CreateStudentDTO studentDTO){
            Student student = new(){
                Id = Guid.NewGuid(),
                FirstName = studentDTO.FirstName,
                LastName = studentDTO.LastName,
                CNP = studentDTO.CNP
            };

            await repository.CreateStudentAsync(student);

            return CreatedAtAction(nameof(GetStudentAsync), new {id = student.Id}, student.AsDto());
        }

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
    }
}