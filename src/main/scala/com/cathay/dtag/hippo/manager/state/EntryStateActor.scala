package com.cathay.dtag.hippo.manager.state

import akka.actor.{ActorRef, ActorSystem, Props}
import akka.persistence.PersistentActor
import akka.pattern.ask
import akka.util.Timeout

import scala.collection.mutable.{Map => MutableMap}
import scala.concurrent.ExecutionContext
import scala.concurrent.duration._
import scala.util.{Failure, Success}


object EntryStateActor {

}