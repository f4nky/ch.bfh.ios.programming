from api.models import Period
from api.models import MemberType, Member
from api.models import EventType, Event
from api.models import Attendance
from api.serializers import PeriodSerializer
from api.serializers import MemberTypeSerializer, MemberSerializer
from api.serializers import EventTypeSerializer, EventSerializer
from api.serializers import AttendanceSerializer
from rest_framework import viewsets
from datetime import datetime

class PeriodViewSet(viewsets.ModelViewSet):
    queryset = Period.objects.all()
    serializer_class = PeriodSerializer

class MemberTypeViewSet(viewsets.ModelViewSet):
    queryset = MemberType.objects.all()
    serializer_class = MemberTypeSerializer
    
class MemberViewSet(viewsets.ModelViewSet):
    queryset = Member.objects.all()
    serializer_class = MemberSerializer
    
class EventTypeViewSet(viewsets.ModelViewSet):
    queryset = EventType.objects.all()
    serializer_class = EventTypeSerializer
    
class EventViewSet(viewsets.ModelViewSet):
    queryset = Event.objects.all()
    serializer_class = EventSerializer
    
class AttendanceViewSet(viewsets.ModelViewSet):
    queryset = Attendance.objects.all()
    serializer_class = AttendanceSerializer
    
class AttendanceFilteredViewSet(viewsets.ModelViewSet):
    serializer_class = AttendanceSerializer
    
    def get_queryset(self):
        queryset = Attendance.objects.all()
        eventdate = self.kwargs.get('eventdate', None)
        
        if eventdate is not None:
            queryset = queryset.filter(event__date=eventdate)
        
        return queryset
