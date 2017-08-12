tasks = []
params_tasks = []

  sorted_tasks = params_tasks.sort_by {|task| (task[:dl] != nil) ? ("#{ 1.0 / task[:impact].to_f }".to_f + task[:dl].to_f) : ("#{1.0 / task[:impact].to_f}".to_f + 200000.0)}
  tasks = sorted_tasks

def input_task(tasks)
  task = {}

  while true
    puts "タスク名を記入してください"
    task[:name] = gets.chomp
    break if task[:name] != ""
  end

  while true
    puts "期限のあるタスクですか？yまたはnを入力してください。"
    choice = gets.chomp
    if choice == "n"
      while true
        puts "タスクの影響力を100段階で入力してください"
        task[:impact] = gets.to_i
        break if task[:impact].between?(1,100)
        puts "1~100の間で入力してください"
      end
      while true
        puts "タスクにかかる時間を分単位で入力してください"
        task[:time] = gets.to_i
        break if task[:time] == task[:time].to_i
        puts "分単位の整数で入力してください"
      end
      task[:dl] = nil
      break
    elsif choice == "y"
      while true
        puts "タスクの影響力を100段階で入力してください"
        task[:impact] = gets.to_i
        break if task[:impact].between?(1,100)
        puts "1~100の間で入力してください"
      end
      while true
        puts "タスクにかかる時間を分単位で入力してください"
        task[:time] = gets.to_i
        break if task[:time] == task[:time].to_i
        puts "分単位の整数で入力してください"
      end
      while true
        while true
          puts "期限の西暦を入力してください(17~18)"
          year = gets.chomp
          break if year.to_i.between?(17,18)
          puts "17~18で入力してください"
        end
        while true
          puts "期限の月を入力してください(01~12で2桁入力)"
          month = gets.chomp
          break if month.to_i.between?(1,12) && month.length == 2
          puts "1~12月の間で2桁で入力してください"
        end
        while true
          puts "期限の日付を入力してください(01~31で2桁入力)"
          day = gets.chomp
          break if day.to_i.between?(1,31) && day.length == 2
          puts "1~31日の間で2桁で入力してください"
        end
        task[:dl] = "#{ year.to_s + month.to_s + day.to_s }".to_i
        break
      end
      break
    else
      puts "不正な値です。もう一度入力してください。"
    end
  end

  tasks << task
  sorted_tasks = tasks.sort_by {|task| (task[:dl] != nil) ? ("#{ 1.0 / task[:impact].to_f }".to_f + task[:dl].to_f) : ("#{1.0 / task[:impact].to_f}".to_f + 200000.0)}

  return sorted_tasks
end

def ls_tasks(tasks)
  sum = 0
  n = 0
  line = "---------------------------"
  if tasks.length != 0
    puts line
    tasks.each_with_index do |task, i|
      puts "[#{i+1}]:#{task[:name]} 影響力：#{task[:impact]} 所要時間：#{task[:time]}分 期限：#{task[:dl] || "なし"}"
      n += 1
      sum += task[:time]
      puts line if n % 5 == 0
    end
    puts line
    if sum.between?(1,59)
      puts "合計所要時間：#{sum}分"
    elsif 60 <= sum
      puts "合計所要時間：#{sum / 60}時間 #{sum % 60}分"
    end
    puts line
  else
    puts "登録されたタスクが存在しません"
  end
end

def dl_tasks(tasks)
  n = 0
  line = "---------------------------"
  if 1 <= tasks.length
    puts line
    tasks.each_with_index do |task, i|
      puts "[#{i+1}]:#{task[:name]} 影響力：#{task[:impact]} 所要時間：#{task[:time]}分 期限：#{task[:dl] || "なし"}"
      n += 1
      puts line if n % 5 == 0
    end
    puts line
    puts "削除したいタスクの番号を選んでください\n削除を取りやめる場合はENTERを押してください"
    input = gets.to_i
    tasks.delete_at(input-1) if input.between?(1,tasks.length)
    return tasks
  else
    puts "登録されたタスクが存在しません"
  end
end

def buckup_tasks(tasks)
  line = "---------------------------"
  if tasks.length != 0
    puts line
    tasks.each do |task|
      p task
    end
    puts line
  else
    puts "登録されたタスクが存在しません"
  end
end

while true

  puts "[1]:タスクを入力する\n[2]:タスク一覧を見る\n[3]:タスクを削除する\n[4]:バックアップ用コマンド"
  input = gets.to_i

  if input == 1
    tasks = input_task(tasks)
  elsif input == 2
    ls_tasks(tasks)
  elsif input == 3
    tasks = dl_tasks(tasks)
  elsif input == 4
    buckup_tasks(tasks)
  else
    puts "不正な値です。もう一度入力してください。"
  end

end
