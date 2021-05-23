using System;

namespace TalesOfAForthGrade.Api.DTO.Professor
{
    public record UpdateProfessorDTO{
        public string LastName { get; init; }
        public string FirstName { get; init; }
        public string Subject { get; init; }
    }
}