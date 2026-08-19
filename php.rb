module PHP
  refine Object do
    def echo(*parts) = (print parts.join; print "\n") # echo "a" + "b";
    def array(*items) = items                         # array(1, 2, 3)
    def isset(x) = !x.nil?                             # isset($x)
    def count(x) = x.size                              # count($x)
    def strlen(s) = s.length
    def implode(glue, xs) = xs.join(glue)             # implode(", ", $x)

    def function(input)
      define_singleton_method(input[0]) { |*args, **kwargs| input[1].call(*args, **kwargs) }
    end
  end
end

using PHP

def method_missing(name, *args, **kwargs, &block)
  return nil if %i(to_a to_hash to_io to_str to_ary to_int).include?(name)

  [name, block]
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

# ===== end "PHP" =======
