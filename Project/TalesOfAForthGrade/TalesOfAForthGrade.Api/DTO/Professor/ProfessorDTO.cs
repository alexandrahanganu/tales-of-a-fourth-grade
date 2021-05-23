using System;

namespace TalesOfAForthGrade.Api.DTO.Professor
{
    public record ProfessorDTO{
        public Guid Id { get; init; }
        public string LastName { get; init; }
        public string FirstName { get; init; }
        public Guid Subject { get; init; }
    }
}