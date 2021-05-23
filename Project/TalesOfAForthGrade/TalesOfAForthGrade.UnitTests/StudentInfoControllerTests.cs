using System;
using System.Linq;
using System.Threading.Tasks;
using FluentAssertions;
using Microsoft.AspNetCore.Mvc;
using Moq;
using TalesOfAForthGrade.Api.Controllers;
using TalesOfAForthGrade.Api.DTO.Student;
using TalesOfAForthGrade.Api.Entities;
using TalesOfAForthGrade.Api.Repositories;
using TalesOfAForthGrade.Helper;
using Xunit;

namespace TalesOfAForthGrade.UnitTests
{
    public class StudentInfoControllerTests
    {
        private readonly Mock<IStudentsRepository> repositoryStub = new();
        private readonly Mock<IGradesRepository> gradesRepositoryStub = new();
        private readonly Mock<ISubjectsRepository> subjectRepositoryStub = new();
        private readonly Mock<IAbsensesRepository> absencesRepositoryStub = new();
        private readonly Mock<IAssignmentsRepository> assignmentsRepositoryStub = new();

        private readonly static Random rand = new();
        private const string alphaNumerical = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";

        private const string numerical = "0123456789";

        [Fact]
        public async Task GetStudentAsync_WithUnexistingStudent_ReturnsNotFound()
        {
            // Arrange
            repositoryStub.Setup(repo => repo.GetStudentAsync(It.IsAny<Guid>()))
                .ReturnsAsync((Student)null);

            var controller = new StudentsInfoController(repositoryStub.Object, null, null, null, null);

            // Act
            var result = await controller.GetStudentAsync(Guid.NewGuid());

            // Assert
            Assert.IsType<NotFoundObjectResult>(result.Result);
        }

        [Fact]
        public async Task GetStudentAsync_WithExistingStudent_ReturnsExpectedStudent()
        {

            //Arange
            var expectedStudent = CreateRandomStudent();

            var randomSubject = CreateRandomSubject();

            repositoryStub.Setup(repo => repo.GetStudentAsync(It.IsAny<Guid>()))
                .ReturnsAsync(expectedStudent);
                
            gradesRepositoryStub.Setup(repo => repo.GetGradesStudentAsync(It.IsAny<Guid>()))
                .ReturnsAsync(Array.Empty<Grade>());

            subjectRepositoryStub.Setup(repo => repo.GetSubjectAsync(It.IsAny<Guid>()))
                .ReturnsAsync(randomSubject);

            absencesRepositoryStub.Setup(repo => repo.GetAbsencesStudentAsync(It.IsAny<Guid>()))
                .ReturnsAsync(Array.Empty<Absence>());

            assignmentsRepositoryStub.Setup(repo => repo.GetAssignmentsStudentAsync(It.IsAny<Guid>()))
                .ReturnsAsync(Array.Empty<Assignment>());
            
            var controller = new StudentsInfoController(repositoryStub.Object, gradesRepositoryStub.Object, subjectRepositoryStub.Object, absencesRepositoryStub.Object, assignmentsRepositoryStub.Object);

            // Act
            var result = await controller.GetStudentAsync(Guid.NewGuid());

            //Assert
            Assert.IsType<StudentProfileDTO>(result.Value);
            var dto = (result as ActionResult<StudentProfileDTO>).Value;

            dto.Should().BeEquivalentTo(
                            expectedStudent,
                            options => options.ComparingByMembers<Student>().ExcludingMissingMembers()
                        );
        }

        [Fact]
        public async Task GetStudentsAsync_WithExistingStudents_ReturnsAllStudents()
        {
            

            //Arange
            var expectedStudents = new[] {CreateRandomStudent(), CreateRandomStudent(), CreateRandomStudent()};

            repositoryStub.Setup(repo => repo.GetStudentsAsync())
                .ReturnsAsync(expectedStudents);
            
            var controller = new StudentsInfoController(repositoryStub.Object, gradesRepositoryStub.Object, subjectRepositoryStub.Object, absencesRepositoryStub.Object, assignmentsRepositoryStub.Object);

            // Act
            var results = await controller.GetStudentsAsync();
            var resultsArray = results.ToArray();
            //Assert
            resultsArray.Should().BeEquivalentTo(
                expectedStudents,
                options => options.ComparingByMembers<Student>().ExcludingMissingMembers()
            );

        }

        [Fact]
        public async Task CreateStudentsAsync_WithStudentsToCreate_ReturnsCreatedStudent(){
            //Arange
            var studentsToCreate = new[] {CreateRandomStudentDTO(), CreateRandomStudentDTO(), CreateRandomStudentDTO()};
            var controller = new StudentsInfoController(repositoryStub.Object, gradesRepositoryStub.Object, subjectRepositoryStub.Object, absencesRepositoryStub.Object, assignmentsRepositoryStub.Object);

            //Act
            var results = await controller.CreateStudentsAsync(studentsToCreate.ToList());
            var resultsArray = results.ToArray();
            //Assert
            resultsArray.Should().BeEquivalentTo(
                studentsToCreate,
                options => options.ComparingByMembers<CreateStudentDTO>().ExcludingMissingMembers()
            );
        }

        [Fact]
        public async Task UpdateStudentAsync_WithExistingStudent_ReturnsNoContent(){
            //Arange
            //Arange
            var expectedStudent = CreateRandomStudent();

            var randomSubject = CreateRandomSubject();

            repositoryStub.Setup(repo => repo.GetStudentAsync(It.IsAny<Guid>()))
                .ReturnsAsync(expectedStudent);
                
            gradesRepositoryStub.Setup(repo => repo.GetGradesStudentAsync(It.IsAny<Guid>()))
                .ReturnsAsync(Array.Empty<Grade>());

            subjectRepositoryStub.Setup(repo => repo.GetSubjectAsync(It.IsAny<Guid>()))
                .ReturnsAsync(randomSubject);

            absencesRepositoryStub.Setup(repo => repo.GetAbsencesStudentAsync(It.IsAny<Guid>()))
                .ReturnsAsync(Array.Empty<Absence>());

            assignmentsRepositoryStub.Setup(repo => repo.GetAssignmentsStudentAsync(It.IsAny<Guid>()))
                .ReturnsAsync(Array.Empty<Assignment>());

            UpdateStudentDTO studentsToUpdate = new(){
                LastName = Guid.NewGuid().ToString(),
                FirstName = Guid.NewGuid().ToString(),
                CNP = RandomString(13, numerical)
            };
            var controller = new StudentsInfoController(repositoryStub.Object, gradesRepositoryStub.Object, subjectRepositoryStub.Object, absencesRepositoryStub.Object, assignmentsRepositoryStub.Object);

            //Act

            var result = await controller.UpdateStudentAsync(expectedStudent.Id, studentsToUpdate);

            //Assert

            result.Should().BeOfType<NoContentResult>();
        }

        [Fact]
        public async Task UpdateStudentAsync_WithUnexistingStudent_ReturnsNotFound(){
            // Arrange
            repositoryStub.Setup(repo => repo.GetStudentAsync(It.IsAny<Guid>()))
                .ReturnsAsync((Student)null);

            var controller = new StudentsInfoController(repositoryStub.Object, null, null, null, null);

            // Act
            UpdateStudentDTO studentsToUpdate = new(){
                LastName = Guid.NewGuid().ToString(),
                FirstName = Guid.NewGuid().ToString(),
                CNP = RandomString(13, numerical)
            };

            var result = await controller.UpdateStudentAsync(Guid.NewGuid(), studentsToUpdate);

            // Assert
            result.Should().BeOfType<NotFoundResult>();
        }


        [Fact]
        public async Task DeleteStudentAsync_WithExistingStudent_ReturnsNoContent(){
            //Arange
            //Arange
            var expectedStudent = CreateRandomStudent();

            var randomSubject = CreateRandomSubject();

            repositoryStub.Setup(repo => repo.GetStudentAsync(It.IsAny<Guid>()))
                .ReturnsAsync(expectedStudent);
                
            gradesRepositoryStub.Setup(repo => repo.GetGradesStudentAsync(It.IsAny<Guid>()))
                .ReturnsAsync(Array.Empty<Grade>());

            subjectRepositoryStub.Setup(repo => repo.GetSubjectAsync(It.IsAny<Guid>()))
                .ReturnsAsync(randomSubject);

            absencesRepositoryStub.Setup(repo => repo.GetAbsencesStudentAsync(It.IsAny<Guid>()))
                .ReturnsAsync(Array.Empty<Absence>());

            assignmentsRepositoryStub.Setup(repo => repo.GetAssignmentsStudentAsync(It.IsAny<Guid>()))
                .ReturnsAsync(Array.Empty<Assignment>());

            UpdateStudentDTO studentsToUpdate = new(){
                LastName = Guid.NewGuid().ToString(),
                FirstName = Guid.NewGuid().ToString(),
                CNP = RandomString(13, numerical)
            };
            var controller = new StudentsInfoController(repositoryStub.Object, gradesRepositoryStub.Object, subjectRepositoryStub.Object, absencesRepositoryStub.Object, assignmentsRepositoryStub.Object);

            //Act

            var result = await controller.DeleteStudent(expectedStudent.Id);

            //Assert

            result.Should().BeOfType<NoContentResult>();
        }

        [Fact]
        public async Task DeleteStudentAsync_WithUnexistingStudent_ReturnsNotFound(){
            // Arrange
            repositoryStub.Setup(repo => repo.GetStudentAsync(It.IsAny<Guid>()))
                .ReturnsAsync((Student)null);

            var controller = new StudentsInfoController(repositoryStub.Object, null, null, null, null);

            // Act
            UpdateStudentDTO studentsToUpdate = new(){
                LastName = Guid.NewGuid().ToString(),
                FirstName = Guid.NewGuid().ToString(),
                CNP = RandomString(13, numerical)
            };

            var result = await controller.DeleteStudent(Guid.NewGuid());

            // Assert
            result.Should().BeOfType<NotFoundResult>();
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

        private CreateStudentDTO CreateRandomStudentDTO(){
            return new(){
                LastName = Guid.NewGuid().ToString(),
                FirstName = Guid.NewGuid().ToString(),
                CNP = RandomString(13, numerical)
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
