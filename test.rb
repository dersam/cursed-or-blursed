# Verify that rb.php produces identical output whether run through the Ruby
# harness (php.rb) or the real PHP interpreter.

dir = __dir__
Dir.chdir(dir) do
  ruby_out = `ruby php.rb 2>/dev/null`
  php_out  = `php rb.php 2>/dev/null`

  if ruby_out == php_out
    puts "PASS: php.rb and rb.php produce identical output (#{ruby_out.bytesize} bytes)"
    exit 0
  else
    warn "FAIL: outputs differ"
    warn "--- ruby php.rb ---"
    warn ruby_out
    warn "--- php rb.php ---"
    warn php_out
    exit 1
  end
end
