using System;
using Microsoft.AspNetCore.Mvc;

using TalesOfAForthGrade.Api.Repositories;
using TalesOfAForthGrade.Api.Entities;
using System.Threading.Tasks;
using TalesOfAForthGrade.Api.DTO.Professor;
using System.Collections.Generic;
using Microsoft.AspNetCore.Authorization;
using TalesOfAForthGrade.Api.Helper;
using System.Linq;
using TalesOfAForthGrade.Helper;

namespace TalesOfAForthGrade.Api.Controllers
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

        [Authorize(Roles = "Admin")]
        [HttpGet]
        public async Task<IEnumerable<ProfessorDataDTO>> GetProfessors(){
            List<ProfessorDataDTO> professorDataDTOs = new List<ProfessorDataDTO>();

            var profs = (await professorRepository.GetProfessorsAsync());

            foreach (Professor prof in profs)
            {
                Subject subject = await subjectsRepository.GetSubjectAsync(prof.Subject);
                professorDataDTOs.Add(prof.AsDataDto(subject.Title));
            }

            return professorDataDTOs;
        }

        [HttpGet("{id}")]
        public async Task<ActionResult<ProfessorDataDTO>> GetProfessor(string id){
            Professor professor = await professorRepository.GetProfessorAsync(Guid.Parse(User.Claims.FirstOrDefault(a => a.Type == "id").Value));
            
            if(professor == null){
                professor = (await professorRepository.GetProfessorAsync(Guid.Parse(id)));
                if(professor == null){
                    return NotFound(new {
                        message = "Professor was not found",
                    });
                }
                string subject = (await subjectsRepository.GetSubjectAsync(professor.Subject)).Title;
                return professor.AsDataDto(subject);
            }else{
                string subject = (await subjectsRepository.GetSubjectAsync(professor.Subject)).Title;
                return (professor.AsDataDto(subject));
            }
        }


        [Authorize(Roles = "Admin")]
        [HttpPost]
        [Route("list")]
        public async Task<IEnumerable<NewlyCreatedProfessorDTO>> CreateProfessors(List<CreateProfessorDTO> professorsDTO){
            List<NewlyCreatedProfessorDTO> newlyCreatedProfessorDTOs = new List<NewlyCreatedProfessorDTO>();
            
            foreach(CreateProfessorDTO professorDTO in professorsDTO){
                Subject subject = await subjectsRepository.GetSubjectAsync(professorDTO.Subject);

                if(subject == null){
                    subject = new Subject(){
                        Id = Guid.NewGuid(),
                        Title = professorDTO.Subject
                    };

                    await subjectsRepository.CreateSubjectAsync(subject);
                }

                Guid id = Guid.NewGuid();
                string password = RandomHelper.GenerateRandomString(12);
                string hashedPassword = CryptoHelper.hashPassword(password);

                newlyCreatedProfessorDTOs.Add(new(){
                    Id = id,
                    LastName = professorDTO.LastName,
                    FirstName = professorDTO.FirstName,
                    username = professorDTO.FirstName.ToLower() + "." + professorDTO.LastName.ToLower(),
                    Subject = subject.Title,
                    Password = password
                });

                Professor professor = new Professor(){
                    Id = id,
                    LastName = professorDTO.LastName,
                    FirstName = professorDTO.FirstName,
                    username = professorDTO.FirstName.ToLower() + "." + professorDTO.LastName.ToLower(),
                    Subject = subject.Id,
                    Password = hashedPassword
                };

                await professorRepository.CreateProfessorAsync(professor);
            }

            return newlyCreatedProfessorDTOs;
        }


        [Authorize(Roles = "Admin")]
        [HttpPut("{id}")]
        public async Task<ActionResult> UpdateProfessorAsync(Guid id, UpdateProfessorDTO professorDTO){
            var existingItem = await professorRepository.GetProfessorAsync(id);

            if(existingItem is null){
                return NotFound();
            }

            Subject subject = await subjectsRepository.GetSubjectAsync(professorDTO.Subject);

            if(subject == null){
                subject = new Subject(){
                    Id = Guid.NewGuid(),
                    Title = professorDTO.Subject
                };

                await subjectsRepository.CreateSubjectAsync(subject);
            }

            Professor updatedProffesor = existingItem with {
                FirstName = professorDTO.FirstName,
                LastName = professorDTO.LastName,
                username = professorDTO.FirstName.ToLower() + "." + professorDTO.LastName.ToLower(),
                Subject = subject.Id,
            };

            await professorRepository.UpdateProfessorAsync(updatedProffesor);

            return NoContent();
        }

        [Authorize(Roles = "Admin")]
        [HttpDelete("{id}")]
        public async Task<ActionResult> DeleteProfessor(Guid id){
            var existingItem = await professorRepository.GetProfessorAsync(id);

            if(existingItem is null){
                return NotFound();
            }

            professorRepository.DeleteProfessorAsync(existingItem.Id);

            return NoContent();
        }
    }
}