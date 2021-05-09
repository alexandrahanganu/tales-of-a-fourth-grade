using System.Collections.Generic;
using Microsoft.AspNetCore.Mvc;

using TalesOfAForthGrade.Repositories;
using TalesOfAForthGrade.DTO.Student;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Authorization;
using System.Security.Claims;
using TalesOfAForthGrade.Helper;
using Microsoft.Extensions.Configuration;
using System.IdentityModel.Tokens.Jwt;
using TalesOfAForthGrade.DTO.Professor;
using TalesOfAForthGrade.DTO.Admin;

namespace TalesOfAForthGrade.Controllers
{   
    [ApiController]
    [Route("auth")]
    public class AuthenticateController : ControllerBase{

        private readonly IStudentsRepository studentRepository;
        private readonly IProfessorRepository professorRepository;
        private readonly IConfiguration Configuration;

        public AuthenticateController(IStudentsRepository studentRepository, IProfessorRepository professorRepository, IConfiguration configuration){
            this.studentRepository = studentRepository;
            this.professorRepository = professorRepository;
            this.Configuration = configuration;
        }
        
        [AllowAnonymous]
        [HttpPost]
        [Route("student")]
        public async Task<ActionResult<object>> AuthenticateStudent(AuthStudentDTO authStudentDTO){
            var student = await studentRepository.GetStudentAsync(authStudentDTO.CNP);

            if (student is null){
                return Unauthorized(new {message = "CNP or Password invalid"});
            }

            if(!CryptoHelper.comparePasswords(authStudentDTO.Password, student.Password)){
                return Unauthorized(new {message = "CNP or Password invalid"});
            }

            var claims = new List<Claim>();
            claims.Add(new Claim("id", student.Id.ToString()));
            claims.Add(new Claim(ClaimTypes.Role, "Student"));
            
            var token = JwtHelper.GetJwtToken(
                student.Id.ToString(),
                Configuration["Jwt:Key"],
                Configuration["Jwt:Issuer"],
                Configuration["Jwt:Issuer"],
                6,
                claims.ToArray());

            return new
            {
                token = new JwtSecurityTokenHandler().WriteToken(token),
                expires = token.ValidTo
            };

        }

        [AllowAnonymous]
        [HttpPost]
        [Route("professor")]
        public async Task<ActionResult<object>> AuthenticateProfessor(AuthProfessorDTO authProfessorDTO){
            var proffessor = await professorRepository.GetProfessorAsync(authProfessorDTO.name);

            if (proffessor is null){
                return Unauthorized(new {message = "Username or Password invalid"});
            }

            if(!CryptoHelper.comparePasswords(authProfessorDTO.Password, proffessor.Password)){
                return Unauthorized(new {message = "Username or Password invalid"});
            }

            var claims = new List<Claim>();
            claims.Add(new Claim("id", proffessor.Id.ToString()));
            claims.Add(new Claim(ClaimTypes.Role, "Professor"));
            
            var token = JwtHelper.GetJwtToken(
                proffessor.Id.ToString(),
                Configuration["Jwt:Key"],
                Configuration["Jwt:Issuer"],
                Configuration["Jwt:Issuer"],
                6,
                claims.ToArray());

            return new
            {
                token = new JwtSecurityTokenHandler().WriteToken(token),
                expires = token.ValidTo
            };

        }

        [AllowAnonymous]
        [HttpPost]
        [Route("admin")]
        public async Task<ActionResult<object>> AuthenticateAdmin(AuthAdminDTO authAdminDTO){
            
            if(authAdminDTO.name != "admin" || authAdminDTO.Password != "admin"){
                return Unauthorized(new {message = "Username or Password invalid"});
            }

            var claims = new List<Claim>();
            claims.Add(new Claim(ClaimTypes.Role, "Admin"));
            
            var token = JwtHelper.GetJwtToken(
                "1",
                Configuration["Jwt:Key"],
                Configuration["Jwt:Issuer"],
                Configuration["Jwt:Issuer"],
                12,
                claims.ToArray());

            return new
            {
                token = new JwtSecurityTokenHandler().WriteToken(token),
                expires = token.ValidTo
            };

        }

        
    }

}