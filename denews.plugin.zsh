# DeNews : Plugin for the latest news related to blockchain

alias denews=deNews()

deNews() {
    local api=""
    local curl_response=""

    if[[ "$1" == "-t" || "$1" == "--token" ]]; then
        local tokenName=$3

        if [[ "$2" == "-a" || "$2" == "--all" ]]; then
            api="/token?filter=all&"
        elif [[ "$2" == "-p" || "$2" == "--price" ]]; then
            api="/token?filter=price&"
        elif [[ "$2" == "-v" || "$2" == "--volume" ]]; then
            api="/token?filter=volume&"
        elif [[ "$2" == "-m" || "$2" == "--marketcap" ]]; then
            api="/token?filter=marketcap&"
        else
            api="/token?filter=all&"
            tokenName=$2
        fi

        api+="tokenName=$tokenName"
        curl_response=$(curl -s "https://caiman-wanted-fox.ngrok-free.app/api$api")
        echo "Token Details: \n$curl_response"

    elif[[ "$1" == "-n" || "$1" == "--news" ]]; then
        api="/news"

        while [[ $# -gt 1 ]]; do
            case "$2" in
                --num)
                    if [[ -z "$api" || "$api" == "/news" ]]; then
                        api="$api?num=$3"
                    else
                        api="$api&num=$3"
                    fi
                    shift 2
                    ;;
                -kw|--keyword)
                    if [[ -z "$api" || "$api" == "/news" ]]; then
                        api="$api?keyword=$3"
                    else
                        api="$api&keyword=$3"
                    fi
                    shift 2
                    ;;
                -h|--help)
                    helpFn
                    shift 1
                    ;;
                *)
                    shift 1
                    ;;
            esac
        done

        if [[ $api == "/news"]]; then
            api="?num=10"
        fi

        if [[ "$2" != "-h" || "$2" != "--help" ]]; then
            curl_response=$(curl -s "https://caiman-wanted-fox.ngrok-free.app/api$api")
            echo "Latest News Headlines: \n$curl_response"
    
    elif [[ "$2" == "--top-tokens" || "$2" == "-tt"]]; then
        api="/top-tokens"
        
        while [[ $# -gt 1 ]]; do
            case "$2" in
                --num)
                    if [[ -z "$api" || "$api" == "/news" ]]; then
                        api="$api?num=$3"
                    else
                        api="$api&num=$3"
                    fi
                    shift 2
                    ;;
                -c|--chain)
                    if [[ -z "$api" || "$api" == "/news" ]]; then
                        api="$api?chain=$3"
                    else
                        api="$api&chain=$3"
                    fi
                    shift 2
                    ;;
                *)
                    shift 1
                    ;;
            esac
        done

        if [[ $api == "/top-tokens"]]; then
            api="?num=10"
        fi

        curl_response=$(curl -s "https://caiman-wanted-fox.ngrok-free.app/api$api")
        echo "Top Tokens: \n$curl_response"
    
    elif [[ "$2" == "--help" || "$2" == "-h" ]]; then
        echo "DeNews: A plugin for the latest news related to blockchain"
        echo "Usage: denews [options] [arguments]"
        echo "Options:"
        echo "  -t, --token       [name] [filter] : Get details of a token"
        echo "  -n, --news        [num] [keyword] : Get the latest news headlines"
        echo "  -tt, --top-tokens [num] [chain]   : Get the top tokens"
        echo "  -h, --help                        : Display this help message"
    else
        echo "Invalid Command! Run 'denews --help' for more information."
    fi
}

helpFn() {

}