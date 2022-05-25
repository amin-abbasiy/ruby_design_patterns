class Math
    def add(a, b)
        a + b
    end
end


math = Math.new
host = 'http://localhost:2000'
drb = DRb.start_service(host, math)
DRb.thread.join