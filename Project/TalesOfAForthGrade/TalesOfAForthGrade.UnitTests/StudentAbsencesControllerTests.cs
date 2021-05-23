using System;
using System.Linq;
using System.Security.Claims;
using System.Threading.Tasks;
using FluentAssertions;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Moq;
using TalesOfAForthGrade.Api.Controllers;
using TalesOfAForthGrade.Api.DTO.Absence;
using TalesOfAForthGrade.Api.DTO.Student;
using TalesOfAForthGrade.Api.Entities;
using TalesOfAForthGrade.Api.Repositories;
using TalesOfAForthGrade.Helper;
using Xunit;

namespace TalesOfAForthGrade.UnitTests
{
    public class StudentAbsencesControllerTests
    {
        private readonly Mock<IStudentsRepository> studentrepositoryStub = new();
        private readonly Mock<IAbsensesRepository> absencesRepositoryStub = new();
       
        private readonly Mock<IProfessorRepository> professorRepositoryStub = new();

        private readonly static Random rand = new();
        private const string alphaNumerical = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";

        private const string numerical = "0123456789";

        
        [Fact]
        public async Task GetStudentAbsences_WithExistingStudent_ReturnExpectedAbsence(){
            //Arange
            var absences = new[] {CreateRandomAbsence(new Guid()), CreateRandomAbsence(new Guid())};
            absencesRepositoryStub.Setup(repo => repo.GetAbsencesStudentAsync(It.IsAny<Guid>()))
                .ReturnsAsync(absences);
            
            var controller = new StudentAbsencesController(studentrepositoryStub.Object, professorRepositoryStub.Object, absencesRepositoryStub.Object);

            //Act
            var results = await controller.GetStudentAbsencesAsync(new Guid());
            var resultsArray = results.ToArray();
            
            //Assert
            resultsArray.Should().BeEquivalentTo(
                absences,
                options => options.ComparingByMembers<Absence>().ExcludingMissingMembers()
            );
        }

        [Fact]
        public async Task CreateAbsence_WithExistingStudent_ReturnExpectedAbsenceDTO(){
            //Arange
            var controller = new StudentAbsencesController(studentrepositoryStub.Object, professorRepositoryStub.Object, absencesRepositoryStub.Object);
            var user = new ClaimsPrincipal(new ClaimsIdentity(new Claim[] {
                new Claim("id", new Guid().ToString()),
            },"TestAuthentication"));
            controller.ControllerContext.HttpContext = new DefaultHttpContext{User = user};

            Guid studentId = new Guid();

            Professor professor = CreateRandomProfessor();
            Student student = CreateRandomStudent(studentId, Array.Empty<Guid>());

            professorRepositoryStub.Setup(repo => repo.GetProfessorAsync(It.IsAny<Guid>()))
                .ReturnsAsync(professor);

            studentrepositoryStub.Setup(repo => repo.GetStudentAsync(It.IsAny<Guid>()))
                .ReturnsAsync(student);

            CreateAbsenceDTO createAbsenceDTO = new(){
                Student = studentId,
                Date = new DateTimeOffset()
            };

            //Act
            var result = await controller.AddAbsence(createAbsenceDTO);

            //Assert
            Assert.IsType<CreatedResult>(result.Result);
        }

        [Fact]
        public async Task CreateAbsence_WithNonExistingStudent_ReturnExpectedAbsenceDTO(){
            //Arange
            var controller = new StudentAbsencesController(studentrepositoryStub.Object, professorRepositoryStub.Object, absencesRepositoryStub.Object);
            var user = new ClaimsPrincipal(new ClaimsIdentity(new Claim[] {
                new Claim("id", new Guid().ToString()),
            },"TestAuthentication"));
            controller.ControllerContext.HttpContext = new DefaultHttpContext{User = user};

            Guid studentId = new Guid();

            Professor professor = CreateRandomProfessor();
            Student student = CreateRandomStudent(studentId, Array.Empty<Guid>());

            professorRepositoryStub.Setup(repo => repo.GetProfessorAsync(It.IsAny<Guid>()))
                .ReturnsAsync(professor);

            studentrepositoryStub.Setup(repo => repo.GetStudentAsync(It.IsAny<Guid>()))
                .ReturnsAsync((Student)null);

            CreateAbsenceDTO createAbsenceDTO = new(){
                Student = studentId,
                Date = new DateTimeOffset()
            };

            //Act
            var result = await controller.AddAbsence(createAbsenceDTO);

            //Assert
            Assert.IsType<NotFoundObjectResult>(result.Result);
        }

        [Fact]
        public async Task UpdateAbsence_WithExistingAbsence_ReturnNoContent(){
            //Arange
            Absence absence = CreateRandomAbsence(new Guid());
            absencesRepositoryStub.Setup(repo => repo.GetAbsence(It.IsAny<Guid>()))
                .ReturnsAsync(absence);
            
            var controller = new StudentAbsencesController(studentrepositoryStub.Object, professorRepositoryStub.Object, absencesRepositoryStub.Object);

            UpdateAbsenceDTO updateAbsenceDTO = new(){
                excused = true,
                motivation = "am racit"
            };

            //Act
            var result = await controller.UpdateStudentAbsenceAsync(new Guid(), updateAbsenceDTO);
            
            //Assert
            result.Should().BeOfType<NoContentResult>();
        }

        [Fact]
        public async Task UpdateAbsence_WithNonExistingAbsence_ReturnNoContent(){
            //Arange
            Absence absence = CreateRandomAbsence(new Guid());
            absencesRepositoryStub.Setup(repo => repo.GetAbsence(It.IsAny<Guid>()))
                .ReturnsAsync((Absence)null);
            
            var controller = new StudentAbsencesController(studentrepositoryStub.Object, professorRepositoryStub.Object, absencesRepositoryStub.Object);

            UpdateAbsenceDTO updateAbsenceDTO = new(){
                excused = true,
                motivation = "am racit"
            };

            //Act
            var result = await controller.UpdateStudentAbsenceAsync(new Guid(), updateAbsenceDTO);
            
            //Assert
            result.Should().BeOfType<NotFoundResult>();
        }
        
        private Student CreateRandomStudent(Guid studentId, Guid[] absences){
            return new(){
                Id = studentId,
                LastName = Guid.NewGuid().ToString(),
                FirstName = Guid.NewGuid().ToString(),
                CNP = RandomString(13, numerical),
                Password = CryptoHelper.hashPassword("1234567890123456"),
                Grades = Array.Empty<Guid>(),
                Absences = absences,
                Assignments = Array.Empty<Guid>()
            };
        }

        private Absence CreateRandomAbsence(Guid studentId){
            return new(){
                Id = new Guid(),
                Student = studentId,
                Subject = new Guid(),
                excused = false,
                motivation = "",
                Date = new DateTimeOffset()
            };
        }

        private Professor CreateRandomProfessor(){
            return new(){
                Id = Guid.NewGuid(),
                LastName = Guid.NewGuid().ToString(),
                FirstName = Guid.NewGuid().ToString(),
                Subject = Guid.NewGuid(),
                Password = CryptoHelper.hashPassword("1234567890123456"),
                username = Guid.NewGuid().ToString(),
            };
        }

        private Subject CreateRandomSubject(){
            return new(){
                Id = Guid.NewGuid(),
                Title = "matematica"
            };
        }

        public static string RandomString(int length, string chars)
        {
            return new string(Enumerable.Repeat(chars, length)
            .Select(s => s[rand.Next(s.Length)]).ToArray());
        }
    }
}
