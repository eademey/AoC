using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace AoC_day6
{
    class Day6
    {
        private int[] _memory_bank;
        private IList<int[]> _previous_banks;
        public Day6(int[] memory_bank)
        {
            _memory_bank = memory_bank;
            _previous_banks = new List<int[]>();
        }

        public void Solve_1()
        {
            int counter = 0;
            while (!Check_duplicates())
            {
                Print_memory(_memory_bank);
                Solve_1_Cycle();
                counter++;
                
            }
            Console.WriteLine(counter + " cycles needed to repeat");
        }

        public void Solve_2()       //utilising Solve_1 to find the start of the loop
        {
            Solve_1();
            _previous_banks = new List<int[]>();    //resetting previous memories
            Solve_1();      //last number printed is the amount of cycles in the loop
        }

        private void Solve_1_Cycle()
        {
            int[] current = (int[])_memory_bank.Clone();
            _previous_banks.Add(current);        //clone is enough for int[]
            int highest_index = Find_largest_index();
            int cur_index = (highest_index + 1) % _memory_bank.Length;
            int highest_value = _memory_bank[highest_index];
            _memory_bank[highest_index] = 0;
            for (int i = highest_value; i > 0; i--)
            {
                _memory_bank[cur_index]++;
                cur_index = (cur_index + 1) % _memory_bank.Length;
            }
        }

        private int Find_largest_index()
        {
            int largest = -1;
            int index = 0;
            for (int i = 0; i < _memory_bank.Length; i++)
            {
                if (_memory_bank[i] > largest)
                {
                    largest = _memory_bank[i];
                    index = i;
                }
            }
            return index;
        }
        public void Print_memory(int[] memory_bank)
        {
            String str = "Current memory: ";
            foreach (int unit in memory_bank)
            {
                str += unit.ToString();
            }
            Console.WriteLine(str);
        }

        private Boolean Check_duplicates()  //checks if the pattern has already occurred
        {
            foreach (int[] memory in _previous_banks)
            {
                if (memory.SequenceEqual(_memory_bank))
                {
                    return true;
                }
            }
            return false;
        }
    }


}
