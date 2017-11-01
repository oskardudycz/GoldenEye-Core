﻿using GoldenEye.Backend.Core.DDD.Events.Store;
using System;
using System.Threading.Tasks;

namespace GoldenEye.Backend.Core.DDD.Events.Logging
{
    public class EventStorePipeline<TEvent> : IAsyncEventHandler<TEvent>
        where TEvent : IEvent
    {
        private readonly IEventStore eventStore;

        public EventStorePipeline(IEventStore eventStore)
        {
            this.eventStore = eventStore ?? throw new ArgumentException(nameof(eventStore));
        }

        public async Task Handle(TEvent @event)
        {
            await eventStore.StoreAsync(@event.StreamId, @event);
            await eventStore.SaveChangesAsync();
        }
    }
}