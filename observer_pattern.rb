class Subject
  attr_accessor :name

  def initialize
    @observers = []
  end

  def attach_observer(observer)
    @observers.push(observer)
  end

  def detach_observer(observer)
    @observers.delete(observer)
  end

  def notify_observers
    @observers.each{ |observer| observer.update(self) }
  end
end

class Observer
  def update(subject)
    puts "in observer update"
  end
end

subject = Subject.new
subject.name = "Test subject"
observer_1 = Observer.new
observer_2 = Observer.new
subject.name = "Test subject new name"
subject.attach_observer(observer_1)
subject.attach_observer(observer_2)
subject.notify_observers
