using System;
using MongoDB.Driver;
namespace TalesOfAForthGrade.Entities
{
    public record Student{
        public Guid Id { get; init; }
        public string LastName { get; init; }
        public string FirstName { get; init; }
        public string CNP { get; init; }
        public string Password {get; init;}

        public Guid[] Grades {get; init;}

        public Guid[] Absences {get; init;}
    }
}