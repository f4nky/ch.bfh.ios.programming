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
        fields = ('id', 'name')

class MemberSerializer(serializers.HyperlinkedModelSerializer):
    member_type = MemberTypeSerializer()
    
    class Meta:
        model = Member
        fields = ('id', 'first_name', 'last_name', 'birth_date', 'member_type')
        
class EventTypeSerializer(serializers.HyperlinkedModelSerializer):
    class Meta:
        model = EventType
        fields = ('id', 'name')

class EventSerializer(serializers.HyperlinkedModelSerializer):
    period = PeriodSerializer()
    event_type = EventTypeSerializer()
    
    class Meta:
        model = Event
        fields = ('id', 'date', 'description', 'period', 'event_type')
        
class AttendanceSerializer(serializers.HyperlinkedModelSerializer):
    event = EventSerializer()
    member = MemberSerializer()
    
    class Meta:
        model = Attendance
        fields = ('id', 'status', 'event', 'member')