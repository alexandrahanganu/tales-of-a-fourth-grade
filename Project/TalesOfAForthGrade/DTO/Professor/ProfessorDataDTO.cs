using System;

namespace TalesOfAForthGrade.DTO.Professor
{
    public record ProfessorDataDTO{
        public Guid Id { get; init; }
        public string LastName { get; init; }
        public string FirstName { get; init; }
        public string Subject { get; init; }

        public string username {get; init;}
    }
}