from __future__ import unicode_literals

from django.db import models

class Period(models.Model):
    name = models.CharField(max_length=100)
    
    def __str__(self):
        return self.name

class MemberType(models.Model):
    name = models.CharField(max_length=100)
    abbr = models.CharField(max_length=10, blank=True, null=True)
    
    def __str__(self):
        return self.name
        
class EventType(models.Model):
    name = models.CharField(max_length=100)
    
    def __str__(self):
        return self.name

class Member(models.Model):
    member_type = models.ForeignKey(MemberType, on_delete=models.SET_NULL, null=True)
    first_name = models.CharField(max_length=200)
    last_name = models.CharField(max_length=200)
    birth_date = models.DateField(auto_now_add=False, blank=True, null=True)

    def __str__(self):
        return self.first_name + ' ' + self.last_name

class Event(models.Model):
    period = models.ForeignKey(Period, on_delete=models.CASCADE, null=True)
    event_type = models.ForeignKey(EventType, on_delete=models.SET_NULL, null=True)
    date = models.DateField()
    description = models.CharField(max_length=1024, blank=True, null=True)
    
    def __str__(self):
        return str(self.date)

class Attendance(models.Model):
    STATUSES = (
        ('ANW', 'anwesend'),
        ('ENT', 'entschuldigt'),
        ('UNE', 'unentschuldigt')
    )

    event = models.ForeignKey(Event, on_delete=models.CASCADE, default=-99)
    member = models.ForeignKey(Member, on_delete=models.CASCADE, default=-99)
    status = models.CharField(max_length=3, choices=STATUSES)
    
    def __str__(self):
        return str(self.id)
