from django.db.models.signals import pre_save, post_save
from .models import Source
from django.dispatch import receiver

@receiver(pre_save, sender=Source)
def check_sources_allowed(sender,**kwargs):
    print(sender)

@receiver(post_save, sender=Source)
def check_save(sender, instance,created, **kwargs):
    print(sender, instance, created)
