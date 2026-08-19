module PHP
  @last = global_variables.dup
  class << self; attr_accessor :last; end

  refine Object do
    def echo(*parts) = (print parts.join; print "\n"; PHP.last = global_variables.dup) # echo "a", "b";
    def array(*items) = items                         # array(1, 2, 3)
    def isset(x) = !x.nil?                             # isset($x)
    def count(x) = x.size                              # count($x)
    def strlen(s) = s.length
    def implode(glue, xs) = (PHP.last = global_variables.dup; xs.join(glue)) # implode(", ", $x)

    def function(input)                               # function greet($who) { return ... }
      name, blk, params = input
      define_singleton_method(:__fn_, &blk)           # block becomes a Method so `return` scopes to it
      fn = method(:__fn_)
      define_singleton_method(name) do |*args, **kwargs|
        params&.each_with_index { |p, i| eval("#{p} = args[i]", binding) if args[i] }
        fn.call
      end
      PHP.last = global_variables.dup
    end
  end
end

using PHP
null = nil

def method_missing(name, *args, **kwargs, &block)
  return nil if %i(to_a to_hash to_io to_str to_ary to_int).include?(name)

  if block                                            # function greet($who) { ... }
    [name, block, global_variables - PHP.last]
  else
    [name, block]
  end
end

# ===== begin "PHP" =======

$name  = "Ada Lovelace";
$role  = "Engineer";
$langs = array("Ruby", "PHP", "Assembly");

echo implode(" ", ["Hello,", $name, "!"]);
echo implode(" ", ["Role: ", $role]);

function greet($who) {
  return implode(" ", ["Sup, ", $who]);
}

echo greet("world");
echo implode(" ", ["strlen(name) =", strlen($name)]);
echo isset(null);

# ===== end "PHP" =======
