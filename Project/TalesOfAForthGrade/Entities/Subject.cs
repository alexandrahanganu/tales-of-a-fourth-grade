using System;
namespace TalesOfAForthGrade.Entities
{
    public record Subject{
        public Guid Id { get; init; }
        public string Title { get; init; }

    }
}