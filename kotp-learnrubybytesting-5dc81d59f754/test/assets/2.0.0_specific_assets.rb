module AssetsFor2_0
  My_2_0_proc = Proc.new do |name: 'Joe', amount: 42, **other_params|
  [name, amount, other_params]
  end

  def some_method(*args, name: 'Joe', amount: 42, **other_params )
    "#{name}, #{amount}, glob of arguments = #{args.inspect}" <<
    " other params #{other_params}"
  end

end
