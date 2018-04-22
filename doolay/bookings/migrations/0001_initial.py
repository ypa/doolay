# -*- coding: utf-8 -*-
# Generated by Django 1.9.9 on 2018-04-22 18:56
from __future__ import unicode_literals

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    initial = True

    dependencies = [
        ('experiences', '0005_auto_20170615_0435'),
    ]

    operations = [
        migrations.CreateModel(
            name='Booking',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('customer_email', models.EmailField(max_length=254)),
                ('customer_first_name', models.CharField(max_length=35)),
                ('customer_last_name', models.CharField(max_length=50)),
                ('group_size', models.PositiveSmallIntegerField()),
                ('start_at', models.DateTimeField(verbose_name='Experience start date time')),
                ('special_request', models.TextField(verbose_name='Customer special request')),
                ('price', models.DecimalField(decimal_places=2, max_digits=9)),
                ('currency', models.CharField(choices=[('USD', 'USD'), ('MMK', 'MMK')], default='USD', max_length=3)),
                ('notes', models.TextField(verbose_name='Staff notes')),
                ('time_period', models.PositiveIntegerField(blank=True, null=True, verbose_name='Time period')),
                ('time_unit', models.CharField(default='hour', max_length=10, verbose_name='Time unit')),
                ('confirmation_id', models.CharField(blank=True, max_length=36, null=True, unique=True, verbose_name='Confirmation Number')),
                ('created_at', models.DateTimeField(auto_now_add=True)),
                ('modified_at', models.DateTimeField(auto_now=True)),
                ('experience', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='experiences.ExperiencePage')),
            ],
            options={
                'ordering': ['-created_at'],
            },
        ),
        migrations.CreateModel(
            name='BookingStatus',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('name', models.SlugField()),
                ('description', models.CharField(max_length=255)),
            ],
        ),
        migrations.AddField(
            model_name='booking',
            name='status',
            field=models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='bookings.BookingStatus', verbose_name='Booking Status'),
        ),
        migrations.AlterUniqueTogether(
            name='booking',
            unique_together=set([('experience', 'start_at')]),
        ),
        migrations.AlterIndexTogether(
            name='booking',
            index_together=set([('customer_last_name', 'customer_first_name'), ('customer_email',)]),
        ),
    ]
