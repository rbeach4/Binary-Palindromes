-- Ricky Beach
-- Project 1 Binary Palindrone
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;
with Ada.Text_IO; use Ada.Text_IO;
-- main procedure
procedure binpals is
   type ModType is mod 2**32;
   package Mod_IO is new Ada.Text_IO.Modular_IO (Num => ModType); use Mod_IO;

   -- prints the binary of a number
   procedure printBinary(number: ModType) is
      bit: ModType := 0;
      newNumber: ModType := number;
     begin
      for i in 0 .. 31 loop
         bit := newNumber mod 2;
         newNumber:= newNumber / 2;
         put(bit,1);
      end loop;
   end printBinary;

   -- returns the reverse number of the one passed in
   function reverseNum(number: ModType) return ModType is
      bit: ModType := 0;
      newNumber: ModType := number;
      newBinary: ModType := 0;
   begin
      for i in 0..31 loop
         bit := newNumber mod 2;
         newBinary := newBinary + bit;
          if i /= 31 then
            newBinary := newBinary * 2;
          end if;
         newNumber := newNumber / 2;
      end loop;
      return newBinary;
   end reverseNum;
   -- returns the number after the binary 0's have been cut off
   function removeRight(number: ModType) return ModType is
      tempReturnVal: ModType := number;
      bit: ModType := 0;
   begin
      for i in 0 .. 31 loop
         bit := tempReturnVal mod 2;
         if bit /= 1 then
            tempReturnVal := tempReturnVal / 2;
         else
            exit;
         end if;
      end loop;
      return tempReturnVal;
   end removeRight;

   --helper function to prune the number being passed in
   function prune(number: ModType) return ModType is
   begin
      return removeRight(number);
   end prune;
   --prints the pruned number its self
   procedure printPruned(number: ModType) is
      input: ModType := number;
      bit: ModType := 0;
   begin
      for i in 0 .. 31 loop
         bit := input mod 2;
         if input = 0 then
            exit;
         else
            input := input / 2;
         end if;
         put(bit,1);
      end loop;
   end printPruned;
   -- compares the numbers for the output
   procedure compareOutput(numUno, numDos: ModType) is
   begin
      if numUno = numDos then
        put("  Same");
      else
        put("  Different");
      end if;
   end compareOutput;
   -- variables for the main procedure
   firstNum: ModType;
   x: ModType := 0;
begin
   get(firstNum);
   for i in 1.. firstNum  loop
      get(x);
      Put("Original:");
      put(x,12);put("  ");
      printBinary(reverseNum(x));
      compareOutput(reverseNum(x), x);New_Line;
      put("Reversed:");
      put(reverseNum(x),12);put("  ");
      printBinary(x); New_Line;
      put("Pruned:");
      put(prune(x), 14);put("  ");
      printPruned(prune(reverseNum(x)));
      Set_Col(56);
      compareOutput(prune(x),prune(reverseNum(x)));new_Line;
      put("Reversed:");
      put(prune(reverseNum(x)), 12);put("  ");
      printPruned(prune(x));
      New_Line;New_Line;
   end loop;
   exception
      when Data_Error => Put_Line("You did not enter a number!!");
      when End_Error => Put_Line("reached the end of file!!");
      when Constraint_Error => Put_Line("Should be ModType!!");
      when others => Put_Line("additional error!!");
end binpals;

