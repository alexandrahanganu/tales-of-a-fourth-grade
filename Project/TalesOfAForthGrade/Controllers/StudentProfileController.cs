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

namespace TalesOfAForthGrade.Controllers
{
    [ApiController]
    [Route("profile")]
    public class StudentProfileController : ControllerBase{
        private readonly IStudentsRepository repository;

        public StudentProfileController(IStudentsRepository repository){
            this.repository = repository;
        }

        [Authorize(Roles = "Student")]
        [HttpGet]
        public async Task<ActionResult<StudentDTO>> GetStudentAsync(){

            var id = User.Claims.Where(a => a.Type == "id").FirstOrDefault().Value;

            var student = await repository.GetStudentAsync(Guid.Parse(id));

            if (student is null){
                return BadRequest(new {
                    message = "There was an error with your authentication, please login again, if the problem persists contact your admin",
                });
            }

            return student.AsDto();
        }
    }
}