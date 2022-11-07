def main_func(sudoku)
  return if sudoku.nil? || sudoku.empty?
  solver(sudoku)

end

def solver(sudoku)
  (0...sudoku.length).each do |row|
    (0...sudoku[row].length).each do |col|
      next unless sudoku[row][col] == 0

      1.upto(9).each do |element|
        next unless is_valid?(sudoku, row, col, element)

        sudoku[row][col] = element

        return sudoku if solver(sudoku)

        sudoku[row][col] = 0
      end

      return false
    end
  end

  return true
end

def is_valid?(sudoku, row, col, element)
  (0...9).each do |i|
    return false if sudoku[row][i] != 0 && sudoku[row][i] == element
    return false if sudoku[i][col] != 0 && sudoku[i][col] == element
    return false if sudoku[3 * (row / 3) + i / 3][3 * (col / 3) + i % 3] != 0 &&
      sudoku[3 * (row / 3) + i / 3][3 * (col / 3) + i % 3] == element
  end
end

sudoku = [[5, 3, 0, 0, 7, 0, 0, 0, 0],
          [6, 0, 0, 1, 9, 5, 0, 0, 0],
          [0, 9, 8, 0, 0, 0, 0, 6, 0],
          [8, 0, 0, 0, 6, 0, 0, 0, 3],
          [4, 0, 0, 8, 0, 3, 0, 0, 1],
          [7, 0, 0, 0, 2, 0, 0, 0, 6],
          [0, 6, 0, 0, 0, 0, 2, 8, 0],
          [0, 0, 0, 4, 1, 9, 0, 0, 5],
          [0, 0, 0, 0, 8, 0, 0, 7, 9]]

result = main_func(sudoku)

separator = '-' * 21 + "\n"
result = result.each { |row| row.insert(3, '|').insert(7, '|').insert(11, "\n").join(' ') }
puts result.insert(3, separator).insert(7, separator).join(' ').prepend("\n ").concat("\n")

#width = result.flatten.max.to_s.size + 2
#puts result.map { |a| a.map { |i| i.to_s.rjust(width) }.join }

#result = solve_sudoku(board)
#puts result
