from api.models import Period
from api.models import MemberType, Member
from api.models import EventType, Event
from api.models import Attendance
from rest_framework import serializers

class PeriodSerializer(serializers.HyperlinkedModelSerializer):
    class Meta:
        model = Period
        fields = ('id', 'name')

class MemberTypeSerializer(serializers.HyperlinkedModelSerializer):
    class Meta:
        model = MemberType
        fields = ('id', 'name', 'abbr')

class MemberSerializer(serializers.HyperlinkedModelSerializer):
    member_type = MemberTypeSerializer()
    
    class Meta:
        model = Member
        fields = ('id', 'first_name', 'last_name', 'birth_date', 'member_type')
        
class EventTypeSerializer(serializers.HyperlinkedModelSerializer):
    class Meta:
        model = EventType
        fields = ('id', 'name', 'abbr')

class EventSerializer(serializers.HyperlinkedModelSerializer):
    period = PeriodSerializer(read_only=True)
    event_type = EventTypeSerializer()
    
    class Meta:
        model = Event
        fields = ('id', 'date', 'description', 'period', 'event_type')
        
class AttendanceSerializer(serializers.HyperlinkedModelSerializer):
    event = EventSerializer(read_only=True)
    member = MemberSerializer(read_only=True)
    
    class Meta:
        model = Attendance
        fields = ('id', 'status', 'event', 'member')