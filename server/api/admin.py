from django.contrib import admin

from .models import Period
from .models import MemberType
from .models import EventType
from .models import Member
from .models import Event
from .models import Attendance

admin.site.register(Period)
admin.site.register(MemberType)
admin.site.register(EventType)
admin.site.register(Member)
admin.site.register(Event)
admin.site.register(Attendance)
