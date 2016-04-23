from api.models import MemberType, Member
from api.models import EventType, Event
from api.models import Attendance
from rest_framework import serializers

class MemberTypeSerializer(serializers.HyperlinkedModelSerializer):
    class Meta:
        model = MemberType
        field = ('name')

class MemberSerializer(serializers.HyperlinkedModelSerializer):
    member_type = MemberTypeSerializer()
    
    class Meta:
        model = Member
        fields = ('first_name', 'last_name', 'birth_date', 'member_type')
        
class EventTypeSerializer(serializers.HyperlinkedModelSerializer):
    class Meta:
        model = EventType
        field = ('name')

class EventSerializer(serializers.HyperlinkedModelSerializer):
    event_type = EventTypeSerializer()
    
    class Meta:
        model = Event
        fields = ('date', 'description', 'event_type')
        
class AttendanceSerializer(serializers.HyperlinkedModelSerializer):
    event = EventSerializer()
    member = MemberSerializer()
    
    class Meta:
        model = Attendance
        fields = ('status', 'event', 'member')