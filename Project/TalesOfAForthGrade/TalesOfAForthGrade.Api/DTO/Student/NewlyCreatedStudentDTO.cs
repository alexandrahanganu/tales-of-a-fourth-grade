

using System;
using System.ComponentModel.DataAnnotations;

namespace TalesOfAForthGrade.Api.DTO.Student
{
    public record NewlyCreatedStudentDTO
    {

        public Guid Id {get; init;}

        public string LastName { get; init; }

        public string FirstName { get; init; }

        public string CNP { get; init; }

        public string password {get; init;}
    }
}