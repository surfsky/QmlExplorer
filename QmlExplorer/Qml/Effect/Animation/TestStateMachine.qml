import QtQuick 2.0
import QtQml.StateMachine 1.0 as DSM


/**
StateMachine
qt 5.4
*/
Rectangle {
    DSM.StateMachine {
        id: stateMachine
        initialState: state
        running: true
        DSM.State {
            id: state
            DSM.SignalTransition {
                targetState: finalState
                signal: button.clicked
                guard: guardButton.checked
            }
        }
        DSM.FinalState {
            id: finalState
        }
        onFinished: Qt.quit()
    }
    Row {
        spacing: 2
        Button {
            id: button
            text: "Finish state"
        }

        Button {
            id: guardButton
            checkable: true
            text: checked ? "Press to block the SignalTransition" : "Press to unblock the SignalTransition"
        }
    }
}
