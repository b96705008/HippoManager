package com.cathay.dtag.hippo.manager.app

import akka.persistence.{PersistentActor, SnapshotOffer}
import com.cathay.dtag.hippo.manager.app.HipposState._

class StatePersister(addr: String) extends PersistentActor {

  override def persistenceId: String = addr

  var state = HipposState()

  def updateState(event: Evt): Unit = {
    state = state.updateHippoStatus(event)
  }

  override def receiveRecover: Receive = {
    case evt: Evt =>
      updateState(evt)
    case SnapshotOffer(_, snapshot: HipposState) =>
      state = snapshot
  }

  val snapShotInterval = 1000
  override def receiveCommand: Receive = {
    case Cmd(hs, op) =>
      persist(Evt(hs, op)) { event =>
        updateState(event)
        if (lastSequenceNr % snapShotInterval == 0 && lastSequenceNr != 0) {
          saveSnapshot(state)
        }
      }

      sender() ! UpdateStates

    case GetLocalState =>
      sender() ! state
  }

}