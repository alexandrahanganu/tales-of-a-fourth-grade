using System;

namespace TalesOfAForthGrade.Api.DTO.Professor
{
    public record NewlyCreatedProfessorDTO{
        public Guid Id {get; init;}
        public string LastName { get; init; }
        public string FirstName { get; init; }
        public string Subject { get; init; }
        public string Password {get; init;}

        public string username {get; init;}
    }
}