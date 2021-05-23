using System;
using System.Linq;
using System.Security.Cryptography;

namespace TalesOfAForthGrade.Api.Helper{

    public static class RandomHelper
    {
        const string chars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
        private static RandomNumberGenerator random = new RNGCryptoServiceProvider();

        public static string GenerateRandomString(int length){
             return new string(Enumerable.Repeat(chars, length)
                .Select(s => s[RandomIntFromRNG(s.Length)]).ToArray());
        }

        // Return a random integer between a min and max value.
        private static int RandomIntFromRNG(int max)
        {
            // Generate four random bytes
            byte[] four_bytes = new byte[4];
            random.GetBytes(four_bytes);

            // Convert the bytes to a UInt32
            UInt32 scale = BitConverter.ToUInt32(four_bytes, 0);

            // And use that to pick a random number >= min and < max
            return (int)((max) * (scale / (uint.MaxValue + 1.0)));
        }
    }
}