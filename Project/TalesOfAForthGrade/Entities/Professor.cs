using System;

namespace TalesOfAForthGrade.Entities
{
    public record Professor{
        public Guid Id { get; init; }
        public string LastName { get; init; }
        public string FirstName { get; init; }
        public string username {get; init; }
        public Guid Subject { get; init; }

        public string Password {get; init;}
    }
}