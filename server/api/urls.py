from django.conf.urls import url, include
from rest_framework import routers
from . import views

router = routers.SimpleRouter()
router.register(r'member-types', views.MemberTypeViewSet)
router.register(r'members', views.MemberViewSet)
router.register(r'event-types', views.EventTypeViewSet)
router.register(r'events', views.EventViewSet)
router.register(r'attendance', views.AttendanceViewSet)

urlpatterns = [
    url(r'^', include(router.urls)),
    url(r'^api-auth/', include('rest_framework.urls', namespace='rest_framework'))
]