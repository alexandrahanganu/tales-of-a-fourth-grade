using System;
namespace TalesOfAForthGrade.Entities
{
    public record Student{
        public Guid Id { get; init; }
        public string LastName { get; init; }
        public string FirstName { get; init; }
        public string CNP { get; init; }
    }
}