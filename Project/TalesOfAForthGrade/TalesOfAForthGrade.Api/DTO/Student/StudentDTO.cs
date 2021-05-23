using System;

namespace TalesOfAForthGrade.Api.DTO.Student
{
    public record StudentDTO{

        public Guid Id { get; init; }
        public string LastName { get; init; }
        public string FirstName { get; init; }

        public string CNP {get; init;}
    }
}