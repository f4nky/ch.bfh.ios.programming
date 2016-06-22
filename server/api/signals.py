from django.dispatch import Signal

def create_new_attendance_if_new_event(sender, **kwargs):
    if kwargs.get('created',False):
        from attendance_rest_api.models import Attendance, Member
        members = Member.objects.all()
        for member in members:
            tmpAttendance = Attendance.objects.filter(event=kwargs.get('instance')).filter(member=member)
            if not tmpAttendance:
                Attendance.objects.get_or_create(event=kwargs.get('instance'), member=member)
    return kwargs

def create_new_attendance_if_new_member(sender, **kwargs):
    if kwargs.get('created',False):
        from attendance_rest_api.models import Attendance, Event
        events = Event.objects.all()
        for event in events:
            tmpAttendance = Attendance.objects.filter(event=event).filter(member=kwargs.get('instance'))
            if not tmpAttendance:
                Attendance.objects.get_or_create(event=event, member=kwargs.get('instance'))
    return kwargs