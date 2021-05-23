using System;
using System.Linq;
using System.Security.Claims;
using System.Threading.Tasks;
using FluentAssertions;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Moq;
using TalesOfAForthGrade.Api.Controllers;
using TalesOfAForthGrade.Api.DTO.Assignment;
using TalesOfAForthGrade.Api.DTO.Student;
using TalesOfAForthGrade.Api.Entities;
using TalesOfAForthGrade.Api.Repositories;
using TalesOfAForthGrade.Helper;
using Xunit;

namespace TalesOfAForthGrade.UnitTests
{
    public class StudentAssignmentsControllerTests
    {
        private readonly Mock<IStudentsRepository> studentrepositoryStub = new();
        private readonly Mock<IAssignmentsRepository> assignmentsRepositoryStub = new();
       
        private readonly Mock<IProfessorRepository> professorRepositoryStub = new();

        private readonly static Random rand = new();
        private const string alphaNumerical = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";

        private const string numerical = "0123456789";

        
        [Fact]
        public async Task GetStudentAssignments_WithExistingStudent_ReturnExpectedAssignment(){
            //Arange
            var Assignments = new[] {CreateRandomAssignment(new Guid()), CreateRandomAssignment(new Guid())};
            assignmentsRepositoryStub.Setup(repo => repo.GetAssignmentsStudentAsync(It.IsAny<Guid>()))
                .ReturnsAsync(Assignments);
            
            var controller = new StudentAssignmentsController(studentrepositoryStub.Object, professorRepositoryStub.Object, assignmentsRepositoryStub.Object);

            //Act
            var results = await controller.GetStudentAssignmentsAsync(new Guid());
            var resultsArray = results.ToArray();
            
            //Assert
            resultsArray.Should().BeEquivalentTo(
                Assignments,
                options => options.ComparingByMembers<Assignment>().ExcludingMissingMembers()
            );
        }

        [Fact]
        public async Task CreateAssignment_WithExistingStudent_ReturnExpectedAssignmentDTO(){
            //Arange
            var controller = new StudentAssignmentsController(studentrepositoryStub.Object, professorRepositoryStub.Object, assignmentsRepositoryStub.Object);
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

            CreateAssignmentDTO createAssignmentDTO = new(){
                Student = studentId,
                DateFrom = new DateTimeOffset(),
                DateDue = new DateTimeOffset()
            };

            //Act
            var result = await controller.AddAssignment(createAssignmentDTO);

            //Assert
            Assert.IsType<CreatedResult>(result.Result);
        }

        [Fact]
        public async Task CreateAssignment_WithNonExistingStudent_ReturnExpectedAssignmentDTO(){
            //Arange
            var controller = new StudentAssignmentsController(studentrepositoryStub.Object, professorRepositoryStub.Object, assignmentsRepositoryStub.Object);
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

            CreateAssignmentDTO createAssignmentDTO = new(){
                Student = studentId,
                DateFrom = new DateTimeOffset(),
                DateDue = new DateTimeOffset()
            };

            //Act
            var result = await controller.AddAssignment(createAssignmentDTO);

            //Assert
            Assert.IsType<NotFoundObjectResult>(result.Result);
        }

        [Fact]
        public async Task UpdateAssignment_WithExistingAssignment_ReturnNoContent(){
            //Arange
            Assignment Assignment = CreateRandomAssignment(new Guid());
            assignmentsRepositoryStub.Setup(repo => repo.GetAssignmentAsync(It.IsAny<Guid>()))
                .ReturnsAsync(Assignment);
            
            var controller = new StudentAssignmentsController(studentrepositoryStub.Object, professorRepositoryStub.Object, assignmentsRepositoryStub.Object);

            UpdateAssignmentDTO updateAssignmentDTO = new(){
                Done = true,
                DateDue = new DateTimeOffset()
            };

            //Act
            var result = await controller.UpdateStudentAssignmentAsync(new Guid(), updateAssignmentDTO);
            
            //Assert
            result.Should().BeOfType<NoContentResult>();
        }

        [Fact]
        public async Task UpdateAssignment_WithNonExistingAssignment_ReturnNoContent(){
            //Arange
            Assignment Assignment = CreateRandomAssignment(new Guid());
            assignmentsRepositoryStub.Setup(repo => repo.GetAssignmentAsync(It.IsAny<Guid>()))
                .ReturnsAsync((Assignment)null);
            
            var controller = new StudentAssignmentsController(studentrepositoryStub.Object, professorRepositoryStub.Object, assignmentsRepositoryStub.Object);

            UpdateAssignmentDTO updateAssignmentDTO = new(){
                Done = true,
                DateDue = new DateTimeOffset()
            };

            //Act
            var result = await controller.UpdateStudentAssignmentAsync(new Guid(), updateAssignmentDTO);
            
            //Assert
            result.Should().BeOfType<NotFoundResult>();
        }
        
        private Student CreateRandomStudent(Guid studentId, Guid[] assignments){
            return new(){
                Id = studentId,
                LastName = Guid.NewGuid().ToString(),
                FirstName = Guid.NewGuid().ToString(),
                CNP = RandomString(13, numerical),
                Password = CryptoHelper.hashPassword("1234567890123456"),
                Grades = Array.Empty<Guid>(),
                Absences = Array.Empty<Guid>(),
                Assignments = assignments
            };
        }

        private Assignment CreateRandomAssignment(Guid studentId){
            return new(){
                Id = new Guid(),
                Student = studentId,
                Subject = new Guid(),
                Done = false,
                DateFrom = new DateTimeOffset(),
                DateDue = new DateTimeOffset()
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
