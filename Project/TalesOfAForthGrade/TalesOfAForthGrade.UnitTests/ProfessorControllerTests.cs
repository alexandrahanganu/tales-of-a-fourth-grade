using System;
using System.Linq;
using System.Security.Claims;
using System.Threading.Tasks;
using FluentAssertions;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Moq;
using TalesOfAForthGrade.Api.Controllers;
using TalesOfAForthGrade.Api.DTO.Professor;
using TalesOfAForthGrade.Api.Entities;
using TalesOfAForthGrade.Api.Repositories;
using TalesOfAForthGrade.Helper;
using Xunit;

namespace TalesOfAForthGrade.UnitTests
{
    public class ProfessorControllerTests
    {
        private readonly Mock<IProfessorRepository> repositoryStub = new();
        private readonly Mock<ISubjectsRepository> subjectRepositoryStub = new();


        private readonly static Random rand = new();
        private const string alphaNumerical = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";


        [Fact]
        public async Task GetProfessorAsync_WithUnexistingProfessor_ReturnsNotFound()
        {
            var user = new ClaimsPrincipal(new ClaimsIdentity(new Claim[] {
                new Claim("id", new Guid().ToString()),
            },"TestAuthentication"));
            // Arrange
            repositoryStub.Setup(repo => repo.GetProfessorAsync(It.IsAny<Guid>()))
                .ReturnsAsync((Professor)null);

            var controller = new ProfessorController(repositoryStub.Object, subjectRepositoryStub.Object);
            controller.ControllerContext.HttpContext = new DefaultHttpContext{User = user};
            // Act
            var result = await controller.GetProfessor(new Guid().ToString());

            // Assert
            Assert.IsType<NotFoundObjectResult>(result.Result);
        }

        [Fact]
        public async Task GetProfessorAsync_WithExistingProfessor_ReturnsExpectedProfessor()
        {

            //Arange
            var expectedProfessor = CreateRandomProfessor();

            var randomSubject = CreateRandomSubject();

            repositoryStub.Setup(repo => repo.GetProfessorAsync(It.IsAny<Guid>()))
                .ReturnsAsync(expectedProfessor);

            subjectRepositoryStub.Setup(repo => repo.GetSubjectAsync(It.IsAny<Guid>()))
                .ReturnsAsync(randomSubject);


            var user = new ClaimsPrincipal(new ClaimsIdentity(new Claim[] {
                            new Claim("id", new Guid().ToString()),
                        },"TestAuthentication"));
            
            var controller = new ProfessorController(repositoryStub.Object, subjectRepositoryStub.Object);
            controller.ControllerContext.HttpContext = new DefaultHttpContext{User = user};

            // Act
            var result = await controller.GetProfessor(new Guid().ToString());

            //Assert
            Assert.IsType<ProfessorDataDTO>(result.Value);
            var dto = (result as ActionResult<ProfessorDataDTO>).Value;

            Assert.Equal(dto.Id, expectedProfessor.Id);
            Assert.Equal(dto.LastName, expectedProfessor.LastName);
            Assert.Equal(dto.FirstName, expectedProfessor.FirstName);
            Assert.Equal(dto.username, expectedProfessor.username);
        }

        [Fact]
        public async Task GetProfessorsAsync_WithExistingProfessors_ReturnsAllProfessors()
        {
        
            //Arange
            var expectedProfessors = new[] {CreateRandomProfessor(), CreateRandomProfessor(), CreateRandomProfessor()};

            var randomSubject = CreateRandomSubject();

            repositoryStub.Setup(repo => repo.GetProfessorsAsync())
                .ReturnsAsync(expectedProfessors);

            subjectRepositoryStub.Setup(repo => repo.GetSubjectAsync(It.IsAny<Guid>()))
                .ReturnsAsync(randomSubject);
            
            var controller = new ProfessorController(repositoryStub.Object, subjectRepositoryStub.Object);

            // Act
            var results = await controller.GetProfessors();
            var resultsArray = results.ToArray();
            //Assert
            for(int i =0; i<resultsArray.Length; i++){
                Assert.Equal(resultsArray[i].Id, expectedProfessors[i].Id);
                Assert.Equal(resultsArray[i].LastName, expectedProfessors[i].LastName);
                Assert.Equal(resultsArray[i].FirstName, expectedProfessors[i].FirstName);
                Assert.Equal(resultsArray[i].username, expectedProfessors[i].username);
            }

        }

        [Fact]
        public async Task CreateProfessorsAsync_WithProfessorsToCreate_ReturnsCreatedProfessor(){
            //Arange
            var ProfessorsToCreate = new[] {CreateRandomProfessorDTO(), CreateRandomProfessorDTO(), CreateRandomProfessorDTO()};
            var controller = new ProfessorController(repositoryStub.Object, subjectRepositoryStub.Object);

            //Act
            var results = await controller.CreateProfessors(ProfessorsToCreate.ToList());
            var resultsArray = results.ToArray();
            //Assert
            resultsArray.Should().BeEquivalentTo(
                ProfessorsToCreate,
                options => options.ComparingByMembers<CreateProfessorDTO>().ExcludingMissingMembers()
            );
        }

        [Fact]
        public async Task UpdateProfessorAsync_WithExistingProfessor_ReturnsNoContent(){
            //Arange
            //Arange
            var expectedProfessor = CreateRandomProfessor();

            var randomSubject = CreateRandomSubject();

            repositoryStub.Setup(repo => repo.GetProfessorAsync(It.IsAny<Guid>()))
                .ReturnsAsync(expectedProfessor);
                

            subjectRepositoryStub.Setup(repo => repo.GetSubjectAsync(It.IsAny<Guid>()))
                .ReturnsAsync(randomSubject);


            UpdateProfessorDTO ProfessorsToUpdate = new(){
                LastName = Guid.NewGuid().ToString(),
                FirstName = Guid.NewGuid().ToString(),
                Subject = RandomString(8, alphaNumerical)
            };

            var controller = new ProfessorController(repositoryStub.Object, subjectRepositoryStub.Object);

            //Act

            var result = await controller.UpdateProfessorAsync(expectedProfessor.Id, ProfessorsToUpdate);

            //Assert

            result.Should().BeOfType<NoContentResult>();
        }

        [Fact]
        public async Task UpdateProfessorAsync_WithUnexistingProfessor_ReturnsNotFound(){
            // Arrange
            repositoryStub.Setup(repo => repo.GetProfessorAsync(It.IsAny<Guid>()))
                .ReturnsAsync((Professor)null);

            var controller = new ProfessorController(repositoryStub.Object, subjectRepositoryStub.Object);

            // Act
            UpdateProfessorDTO ProfessorsToUpdate = new(){
                LastName = Guid.NewGuid().ToString(),
                FirstName = Guid.NewGuid().ToString(),
                Subject = RandomString(8, alphaNumerical)
            };

            var result = await controller.UpdateProfessorAsync(Guid.NewGuid(), ProfessorsToUpdate);

            // Assert
            result.Should().BeOfType<NotFoundResult>();
        }


         [Fact]
        public async Task DeleteProfessorAsync_WithExistingProfessor_ReturnsNoContent(){
            
            //Arange
            var expectedProfessor = CreateRandomProfessor();

            var randomSubject = CreateRandomSubject();

            repositoryStub.Setup(repo => repo.GetProfessorAsync(It.IsAny<Guid>()))
                .ReturnsAsync(expectedProfessor);
                

            subjectRepositoryStub.Setup(repo => repo.GetSubjectAsync(It.IsAny<Guid>()))
                .ReturnsAsync(randomSubject);


            UpdateProfessorDTO ProfessorsToUpdate = new(){
                LastName = Guid.NewGuid().ToString(),
                FirstName = Guid.NewGuid().ToString(),
                Subject = RandomString(8, alphaNumerical)
            };

            var controller = new ProfessorController(repositoryStub.Object, subjectRepositoryStub.Object);

            //Act

            var result = await controller.DeleteProfessor(expectedProfessor.Id);

            //Assert

            result.Should().BeOfType<NoContentResult>();
        }

        [Fact]
        public async Task DeleteProfessorAsync_WithUnexistingProfessor_ReturnsNotFound(){
            // Arrange
            repositoryStub.Setup(repo => repo.GetProfessorAsync(It.IsAny<Guid>()))
                .ReturnsAsync((Professor)null);

            var controller = new ProfessorController(repositoryStub.Object, subjectRepositoryStub.Object);

            // Act
            UpdateProfessorDTO ProfessorsToUpdate = new(){
                LastName = Guid.NewGuid().ToString(),
                FirstName = Guid.NewGuid().ToString(),
                Subject = RandomString(8, alphaNumerical)
            };

            var result = await controller.DeleteProfessor(Guid.NewGuid());

            // Assert
            result.Should().BeOfType<NotFoundResult>();
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

        private CreateProfessorDTO CreateRandomProfessorDTO(){
            return new(){
                LastName = Guid.NewGuid().ToString(),
                FirstName = Guid.NewGuid().ToString(),
                Subject = RandomString(8, alphaNumerical)
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
