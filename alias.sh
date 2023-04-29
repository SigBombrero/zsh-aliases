alias ll="ls -lia"
alias cls="clear"
alias gst="git status"
alias k="kubectl"
alias kdp="kubectl describe pod"
alias kds="kubectl describe statefulset"
alias py3="python3"

# The below functions assume you have configured kubectl to use a specified namespace
# Otherwise, add the -n or --namespace flag and provide the namespace or the command will assume the default namespace.
# NOTE: Useful tools -> kubectx, kubens

# output all pods with their associated container images in tabular format.
# takes 1 optional argument which serves as a grep filter
function kpi {
    if [[ -n "$1" ]]
    then
        kubectl get pods -o jsonpath="{range.items[*]}(.metadata.name){' '}{.spec.containers[*].image}{'\n'}{end}" | grep $1 | column -t
    else
        kubectl get pods -o jsonpath="{range.items[*]}(.metadata.name){' '}{.spec.containers[*].image}{'\n'}{end}" | column -t
    fi
}

# output all events for a kubernetes object
# expects object name as argument
function kge {
    if [[ -n "$1" ]]
    then
       kubectl get event --field-selector involvedObject.name="$1"
    else
        echo "Please enter the name of the object for which you want the events (e.g. pod, statefulset, etc.)."
    fi   
}