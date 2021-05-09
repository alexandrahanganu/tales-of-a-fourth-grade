using System;
using System.Linq;

namespace TalesOfAForthGrade.Helper{

    public static class RandomHelper
    {
        const string chars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
        private static Random random = new Random();

        public static string GenerateRandomString(int length){
             return new string(Enumerable.Repeat(chars, length)
                .Select(s => s[random.Next(s.Length)]).ToArray());
        }
    }
}