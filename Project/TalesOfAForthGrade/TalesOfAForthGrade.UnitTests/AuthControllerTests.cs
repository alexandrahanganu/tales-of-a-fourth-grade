using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Claims;
using System.Threading.Tasks;
using FluentAssertions;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Configuration;
using Moq;
using TalesOfAForthGrade.Api.Controllers;
using TalesOfAForthGrade.Api.DTO.Admin;
using TalesOfAForthGrade.Api.DTO.Professor;
using TalesOfAForthGrade.Api.DTO.Student;
using TalesOfAForthGrade.Api.Entities;
using TalesOfAForthGrade.Api.Repositories;
using TalesOfAForthGrade.Helper;
using Xunit;

namespace TalesOfAForthGrade.UnitTests
{
    public class AuthControllerTests
    {
        private readonly Mock<IProfessorRepository> professorRepositoryStub = new();
        private readonly Mock<IStudentsRepository> studentRepositoryStub = new();


        private readonly static Random rand = new();
        private const string alphaNumerical = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
        private const string numerical = "0123456789";

       [Fact]
       public async Task AuthenticateStudent_WithUnexistingStudent_ReturnsUnauthorized(){
           Student student = CreateRandomStudent();

           var inMemorySettings = new Dictionary<string, string> {
            {"Jwt:Key", "SomeSecretKey"},
            {"Jwt:Issuer", "SectionValue"},
            };

            IConfiguration configuration = new ConfigurationBuilder()
                .AddInMemoryCollection(inMemorySettings)
                .Build();

            AuthStudentDTO authStudentDTO = new(){
                CNP = student.CNP,
                Password = student.Password
            };
           // Arrange
           studentRepositoryStub.Setup(repo => repo.GetStudentAsync(It.IsAny<string>()))
                .ReturnsAsync((Student)null);

            var controller = new AuthenticateController(studentRepositoryStub.Object, professorRepositoryStub.Object, configuration);
            // Act
            var result = await controller.AuthenticateStudent(authStudentDTO);
            
            // Assert
            Assert.IsType<UnauthorizedObjectResult>(result.Result);
       }

              [Fact]
       public async Task AuthenticateStudent_WithExistingStudentWrongPassword_ReturnsUnauthorized(){
           Student student = CreateRandomStudent();

           var inMemorySettings = new Dictionary<string, string> {
            {"Jwt:Key", "SomeSecretKey"},
            {"Jwt:Issuer", "SectionValue"},
            };

            IConfiguration configuration = new ConfigurationBuilder()
                .AddInMemoryCollection(inMemorySettings)
                .Build();

            AuthStudentDTO authStudentDTO = new(){
                CNP = student.CNP,
                Password = "wrongPassword"
            };
           // Arrange
           studentRepositoryStub.Setup(repo => repo.GetStudentAsync(It.IsAny<string>()))
                .ReturnsAsync(student);

            var controller = new AuthenticateController(studentRepositoryStub.Object, professorRepositoryStub.Object, configuration);
            // Act
            var result = await controller.AuthenticateStudent(authStudentDTO);
            
            // Assert
            Assert.IsType<UnauthorizedObjectResult>(result.Result);
       }

        [Fact]
        public async Task AuthenticateStudent_WithExistingStudentGoodCredentials_ReturnsToken(){
           // Arrange
           
           Student student = CreateRandomStudent();

           var inMemorySettings = new Dictionary<string, string> {
            {"Jwt:Key", "SomeSecretKeyHAHA"},
            {"Jwt:Issuer", "SectionValue"},
            };

            IConfiguration configuration = new ConfigurationBuilder()
                .AddInMemoryCollection(inMemorySettings)
                .Build();

            AuthStudentDTO authStudentDTO = new(){
                CNP = student.CNP,
                Password = "1234567890123456"
            };
           
           studentRepositoryStub.Setup(repo => repo.GetStudentAsync(It.IsAny<string>()))
                .ReturnsAsync(student);

            var controller = new AuthenticateController(studentRepositoryStub.Object, professorRepositoryStub.Object, configuration);
            // Act
            var result = await controller.AuthenticateStudent(authStudentDTO);
            var resultValue = result.Value;
            // Assert
            Assert.NotNull(resultValue.GetType().GetProperty("token"));
            Assert.NotNull(resultValue.GetType().GetProperty("expires"));
       }

       [Fact]
       public async Task AuthenticateProfessor_WithUnexistingProfessor_ReturnsUnauthorized(){
           Professor professor = CreateRandomProfessor();

           var inMemorySettings = new Dictionary<string, string> {
            {"Jwt:Key", "SomeSecretKeyHAHA"},
            {"Jwt:Issuer", "SectionValue"},
            };

            IConfiguration configuration = new ConfigurationBuilder()
                .AddInMemoryCollection(inMemorySettings)
                .Build();

            AuthProfessorDTO authProfessorDTO = new(){
                name = professor.username,
                Password = professor.Password
            };
           // Arrange
           professorRepositoryStub.Setup(repo => repo.GetProfessorAsync(It.IsAny<string>()))
                .ReturnsAsync((Professor)null);

            var controller = new AuthenticateController(studentRepositoryStub.Object, professorRepositoryStub.Object, configuration);
            // Act
            var result = await controller.AuthenticateProfessor(authProfessorDTO);
            
            // Assert
            Assert.IsType<UnauthorizedObjectResult>(result.Result);
       }

       [Fact]
       public async Task AuthenticateProfessor_WithExistingProfessorWrongPassword_ReturnsUnauthorized(){
           Professor professor = CreateRandomProfessor();

           var inMemorySettings = new Dictionary<string, string> {
            {"Jwt:Key", "SomeSecretKeyHAHA"},
            {"Jwt:Issuer", "SectionValue"},
            };

            IConfiguration configuration = new ConfigurationBuilder()
                .AddInMemoryCollection(inMemorySettings)
                .Build();

            AuthProfessorDTO authProfessorDTO = new(){
                name = professor.username,
                Password = professor.Password
            };
           // Arrange
           professorRepositoryStub.Setup(repo => repo.GetProfessorAsync(It.IsAny<string>()))
                .ReturnsAsync(professor);

            var controller = new AuthenticateController(studentRepositoryStub.Object, professorRepositoryStub.Object, configuration);
            // Act
            var result = await controller.AuthenticateProfessor(authProfessorDTO);
            
            // Assert
            Assert.IsType<UnauthorizedObjectResult>(result.Result);
       }

        [Fact]
        public async Task AuthenticateProfessor_WithExistingProfessorGoodCredentials_ReturnsToken(){
           Professor professor = CreateRandomProfessor();

           var inMemorySettings = new Dictionary<string, string> {
            {"Jwt:Key", "SomeSecretKeyHAHA"},
            {"Jwt:Issuer", "SectionValue"},
            };

            IConfiguration configuration = new ConfigurationBuilder()
                .AddInMemoryCollection(inMemorySettings)
                .Build();

            AuthProfessorDTO authProfessorDTO = new(){
                name = professor.username,
                Password = "1234567890123456"
            };
           // Arrange
           professorRepositoryStub.Setup(repo => repo.GetProfessorAsync(It.IsAny<string>()))
                .ReturnsAsync(professor);

            var controller = new AuthenticateController(studentRepositoryStub.Object, professorRepositoryStub.Object, configuration);
            // Act
            var result = await controller.AuthenticateProfessor(authProfessorDTO);
            var resultValue = result.Value;
            // Assert
            Assert.NotNull(resultValue.GetType().GetProperty("token"));
            Assert.NotNull(resultValue.GetType().GetProperty("expires"));
       }

       [Fact]
       public void AuthenticateAdmin_WithWrongUsername_ReturnsUnauthorized(){

           var inMemorySettings = new Dictionary<string, string> {
            {"Jwt:Key", "SomeSecretKeyHAHA"},
            {"Jwt:Issuer", "SectionValue"},
            };

            IConfiguration configuration = new ConfigurationBuilder()
                .AddInMemoryCollection(inMemorySettings)
                .Build();

            AuthAdminDTO authAdminDTO = new(){
                name = "ceva",
                Password = "ceva"
            };

            var controller = new AuthenticateController(studentRepositoryStub.Object, professorRepositoryStub.Object, configuration);
            // Act
            var result = controller.AuthenticateAdmin(authAdminDTO);
            
            // Assert
            Assert.IsType<UnauthorizedObjectResult>(result.Result);
       }

       [Fact]
       public void AuthenticateAdmin_WithWrongPassword_ReturnsUnauthorized(){

           var inMemorySettings = new Dictionary<string, string> {
            {"Jwt:Key", "SomeSecretKeyHAHA"},
            {"Jwt:Issuer", "SectionValue"},
            };

            IConfiguration configuration = new ConfigurationBuilder()
                .AddInMemoryCollection(inMemorySettings)
                .Build();

            AuthAdminDTO authAdminDTO = new(){
                name = "admin",
                Password = "ceva"
            };

            var controller = new AuthenticateController(studentRepositoryStub.Object, professorRepositoryStub.Object, configuration);
            // Act
            var result = controller.AuthenticateAdmin(authAdminDTO);
            
            // Assert
            Assert.IsType<UnauthorizedObjectResult>(result.Result);
       }

        [Fact]
       public void AuthenticateAdmin_WithGoodCredentials_ReturnsUnauthorized(){

           var inMemorySettings = new Dictionary<string, string> {
            {"Jwt:Key", "SomeSecretKeyHAHA"},
            {"Jwt:Issuer", "SectionValue"},
            };

            IConfiguration configuration = new ConfigurationBuilder()
                .AddInMemoryCollection(inMemorySettings)
                .Build();

            AuthAdminDTO authAdminDTO = new(){
                name = "admin",
                Password = "admin"
            };

            var controller = new AuthenticateController(studentRepositoryStub.Object, professorRepositoryStub.Object, configuration);
            // Act
            var result = controller.AuthenticateAdmin(authAdminDTO);
            var resultValue = result.Value;
            // Assert
            Assert.NotNull(resultValue.GetType().GetProperty("token"));
            Assert.NotNull(resultValue.GetType().GetProperty("expires"));
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

        private Student CreateRandomStudent(){
            return new(){
                Id = Guid.NewGuid(),
                LastName = Guid.NewGuid().ToString(),
                FirstName = Guid.NewGuid().ToString(),
                CNP = RandomString(13, numerical),
                Password = CryptoHelper.hashPassword("1234567890123456"),
                Grades = Array.Empty<Guid>(),
                Absences = Array.Empty<Guid>(),
                Assignments = Array.Empty<Guid>()
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
