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
using TalesOfAForthGrade.DTO.Professor;

namespace TalesOfAForthGrade.Controllers
{
    [ApiController]
    [Route("professor")]
    public class ProfessorController : ControllerBase{
        private readonly IProfessorRepository professorRepository;
        private readonly ISubjectsRepository subjectsRepository;

        public ProfessorController(IProfessorRepository repository, ISubjectsRepository subjectsRepository){
            this.professorRepository = repository;
            this.subjectsRepository = subjectsRepository;
        }

        [HttpGet("{id}")]
        public async Task<ActionResult<ProfessorDTO>> GetProfessor(Guid id){
            return (await professorRepository.GetProfessorAsync(id)).AsDto();
        }

        //[Authorize(Roles = "Admin")]
        [HttpPost]
        public async Task<ActionResult<StudentDTO>> CreateProfessor(CreateProfessorDTO professorDTO){
            Subject subject = await subjectsRepository.GetSubjectAsync(professorDTO.Subject);

            if(subject == null){
                subject = new Subject(){
                    Id = Guid.NewGuid(),
                    Title = professorDTO.Subject
                };

                await subjectsRepository.CreateSubjectAsync(subject);
            }

            Professor professor = new Professor(){
                Id = Guid.NewGuid(),
                LastName = professorDTO.LastName,
                FirstName = professorDTO.FirstName,
                username = professorDTO.FirstName.ToLower() + "." + professorDTO.LastName.ToLower(),
                Subject = subject.Id
            };

            await professorRepository.CreateProfessorAsync(professor);

            return CreatedAtAction(nameof(GetProfessor),  new {id = professor.Id}, professor.AsDto());
        }
    }
}